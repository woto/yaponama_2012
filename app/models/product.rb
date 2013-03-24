# encoding: utf-8
#
class Product < ActiveRecord::Base
  include BelongsToUser
  include BelongsToSupplier
  include BelongsToCreator

  # Продукты по которым ожидается движение
  scope :active, -> { where("STRPOS(?, products.status) > 0", "ordered,pre_supplier,post_supplier,stock") }

  def self.summa
    active.sum("sell_cost * quantity_ordered").to_d
  end

  # Виртуальные аттрибуты
  attr_accessor :delivery_id, :delivery_cost

  # TODO remove later, when normalized situation around edit view product_fields
  attr_accessor :_destroy

  validates :catalog_number, :manufacturer, :presence => true

  validates :buy_cost, :numericality => { :greater_than => 0}
  validates :sell_cost, :numericality => { :greater_than => 0}

  validates :quantity_ordered, :numericality => { :greater_than_or_equal_to => 1, :only_integer => true }

  belongs_to :order

  belongs_to :product

  has_many :products, :dependent => :destroy
  accepts_nested_attributes_for :products, :allow_destroy => true

  validates :status, :inclusion => {:in => Rails.configuration.products_status.select{|k, v| v['real'] == true}.keys}


  #scope :inorder, where(:status => "inorder")

  #before_save :set_relational_attributes_save
  #
  #def set_relational_attributes_save
  #  if self.order.present?
  #    self.user = self.order.user
  #  end
  #end


  # Product Transaction
  #
  has_many :product_transactions
  before_save :log_product_transactions

  def log_product_transactions
    if self.changes.present?
      product_transaction = self.product_transactions.build
      h = {}
      self.changes.map{|k,v| h["log_#{k}"] = v[1]}
      product_transaction.update_attributes(h)
    end
  end
  #
  # /Product Transaction

  #before_save :buy_cost_changes
  #
  #def buy_cost_changes
  #  if self.persisted? && self.changes["buy_cost"]
  #    errors.add(:buy_cost, "Unable to change buy cost, make cancel and reorder")
  #    return false
  #  end
  #end

  before_save :process_before_save

  def process_before_save

    if self.changes["status"]
      old_status = self.changes["status"][0]
      new_status = self.changes["status"][1]

      case old_status

        when 'incart'
          case new_status
            when 'incart'
            when 'inorder'
            when 'cancel'
            else
              errors.add(:status, "Позиция не может изменить свой статус с #{old_status} на #{new_status}")
              return false
          end


        when 'inorder'
          case new_status
            when 'incart'
            when 'inorder'
            when 'cancel'
            when 'ordered'
              user.account(true).credit += (sell_cost * quantity_ordered)
              user.save
            else
              errors.add(:base, "Позиция не может изменить свой статус с #{old_status} на #{new_status}")
              return false
          end


        when 'ordered'
          case new_status
            when 'incart'
              user.account(true).credit -= (sell_cost * quantity_ordered)
              user.save
            when 'cancel'
              user.account(true).credit -= (sell_cost * quantity_ordered)
              user.save
            when 'pre_supplier'
            when 'inorder'
              user.account(true).credit -= (sell_cost * quantity_ordered)
              user.save
            else
              errors.add(:base, "Product can not change status from #{old_status} to #{new_status}")
              return false
            end


        when 'pre_supplier'
          case new_status
          when 'cancel'
            # TODO эта операция должна быть доступна администратору (по согласованию с снабженцем)'
            user.account(true).credit -= (sell_cost * quantity_ordered)
            user.save
          when 'pre_supplier'
          when 'post_supplier'
            supplier.account(true).credit += (buy_cost * quantity_ordered)
            supplier.save
          when 'incart'
            user.account(true).credit -= (sell_cost * quantity_ordered)
            user.save
          when 'inorder'
            user.account(true).credit -= (sell_cost * quantity_ordered)
            user.save
          else
            errors.add(:base, "Product can not change status from #{old_status} to #{new_status}")
            return false
          end


        when 'post_supplier'
          case new_status
          when 'pre_supplier'
            supplier.account(true).credit -= (buy_cost * quantity_ordered)
            supplier.save
          when 'cancel'
            # TODO эта операция должна быть доступна администратору (по согласованию с снабженцем)'
            user.account.credit -= sell_cost * quantity_ordered
            supplier.account.credit -= buy_cost * quantity_ordered
            user.save
            supplier.save
          when 'stock'
            supplier.account(true).credit -= buy_cost * quantity_ordered
            supplier.account.debit -= buy_cost * quantity_ordered
            supplier.save
          else
            errors.add(:base, "Product can not change status from #{old_status} to #{new_status}")
            return false
          end

        when 'stock'
          case new_status
          when 'cancel'
            # TODO эта операция должна быть доступна администратору (по согласованию с снабженцем)'
            user.account(true).credit -= sell_cost * quantity_ordered
            user.save
          when 'post_supplier'
            supplier.account(true).credit += (buy_cost * quantity_ordered)
            supplier.account.debit += buy_cost * quantity_ordered
            supplier.save
          when 'complete'
            user.account(true).credit -= sell_cost * quantity_ordered
            user.account.debit -= sell_cost * quantity_ordered
            user.save
          else
            errors.add(:base, "Product can not change status from #{old_status} to #{new_status}")
            return false
          end

        when 'complete'
          case new_status
          when 'cancel'
            # WTF? TODO эта операция должна быть доступна администратору (по согласованию с снабженцем)'
            # user.account(true).credit -= sell_cost * quantity_ordered
            # user.save
          when 'stock'
            user.account(true).credit += sell_cost * quantity_ordered
            user.account.debit += sell_cost * quantity_ordered
            user.save
          else
            errors.add(:base, "Product can not change status from #{old_status} to #{new_status}")
            return false
          end

        when 'cancel'
          case new_status
          when 'incart'
          when 'inorder'
          when 'ordered'
          when 'pre_supplier'
          when 'post_supplier'
          when 'stock'
          when 'complete'
          else
            errors.add(:base, "Product can not change status from #{old_status} to #{new_status}")
            return false
          end
      end
    # Если не происходила смена статуса
    else

      # При смене поставщика не присходит смена статуса
      # случай если меняется только поставщик post_supplier -> post_supplier
      if self.supplier_id_changed?
        ActiveRecord::Base.transaction do
          supplier_was = Supplier.find(changes["supplier_id"][0])
          supplier_was.account(true).credit -= (buy_cost * quantity_ordered) 
          supplier_was.save
          supplier.account(true).credit += (buy_cost * quantity_ordered)
          supplier.save
        end
      end

      # TODO необходимо доработать в контроллере вопрос уведомления покупателя
      if sell_cost_changed? || quantity_ordered_changed?
        if ["ordered", "pre_supplier", "post_supplier", "stock"].include? status
          user.account(true).credit += ( (sell_cost * quantity_ordered) - (sell_cost_was * quantity_ordered_was) )
          user.save
        elsif ["incart", "inorder"].include? status
        else
          if sell_cost_changed?
            errors.add(:sell_cost, "Невозможно изменить продажную цену у позиции в данном статусе.")
          end
          if quantity_ordered_changed?
            errors.add(:quantity_ordered, "Невозможно изменить количество у позиции в данном статусе.")
          end
        end
      end

      if buy_cost_changed? || quantity_ordered_changed?
        if ["post_supplier"].include? status
          supplier.account(true).credit += ( (buy_cost * quantity_ordered) - (buy_cost_was * quantity_ordered_was) )
          supplier.save
        elsif ["incart", "inorder", "ordered", "pre_supplier"].include? status
        else
          if buy_cost_changed?
            errors.add(:buy_cost, "Невозможно изменить закупочную цену у позиции в данном статусе.")
          end
          if quantity_ordered_changed?
            errors.add(:quantity_ordered, "Невозможно изменить количество у позиции в данном статусе.")
          end
        end
      end

      if errors.any?
        return false
      end

    end
  end

  before_validation :set_relational_attributes_validation
  
  def set_relational_attributes_validation

    # У новых товаров статус по-умолчанию - в корзине
    if self.status == nil
      self.status = "incart"
    end

    if self.products.present? && self.status != 'cancel'
      errors.add(:base, 'Невозможно перезаказать товар, пока по нему не выставлен отказ.')
    end

    if self.user.present?
      self.products.each do |product|
        product.user = self.user
      end
    end

    #if self.order.present?
    #  self.user = self.order.user
    #  self.products.each do |product|
    #    product.order = self.order
    #    product.user = self.user
    #  end
    #end

  end

  #before_destroy :process_before_destroy
 
  #def process_before_destroy
  #  unless ["incart", "inorder", "ordered"].include? status
  #    errors.add(:base, "Not in status incart, inorder or ordered.")
  #    return false
  #  end

  #  if ["ordered"].include? status
  #    user.account.debit -= sell_cost * quantity_ordered
  #    user.save
  #  end
  #end


  def to_label
    catalog_number + " - " + manufacturer

  end

end
