# encoding: utf-8
#
class Product < ActiveRecord::Base
  include BelongsToSomebody
  include BelongsToSupplier
  include BelongsToCreator
  include Transactionable
  include HiddenRecreate
  include Selectable
  include Code_1AttrAccessorAndValidation
  include SetCreationReasonBasedOnCode_1
  include CachedBrand
  include BrandAttributes

  # Продукты по которым ожидается движение
  scope :active, -> { where("products.status IN (?)", ["ordered", "pre_supplier", "post_supplier", "stock"]) }
  # TODO позже пригодится для расчета суммы для внесения пользователем для оформления заказа

  def self.summa
    sum("sell_cost * quantity_ordered").to_d
  end

  # Виртуальные аттрибуты
  attr_accessor :delivery_id, :delivery_cost

  # TODO remove later, when normalized situation around edit view product_fields
  #attr_accessor :_destroy

  validates :catalog_number, :presence => true

  belongs_to :brand
  validates :brand, :presence => true

  validates :buy_cost, :numericality => { :greater_than => 0}
  validates :sell_cost, :numericality => { :greater_than => 0}

  validates :quantity_ordered, :numericality => { :greater_than_or_equal_to => 1, :only_integer => true }

  belongs_to :order

  belongs_to :product

  has_many :products
  #accepts_nested_attributes_for :products, :allow_destroy => true

  validates :status, :inclusion => {:in => Rails.configuration.products_status.select{|k, v| v['real'] == true}.keys}

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
              raise "Позиция не может изменить свой статус с #{old_status} на #{new_status}"
          end


        when 'inorder'
          case new_status
            when 'incart'
            when 'inorder'
            when 'cancel'
            when 'ordered'
              @transaction.account_transactions.create(:account => somebody.account, :credit => sell_cost * quantity_ordered)
            else
              raise "Позиция не может изменить свой статус с #{old_status} на #{new_status}"
          end


        when 'ordered'
          case new_status
            when 'incart'
              @transaction.account_transactions.create(:account => somebody.account, :credit => -(sell_cost * quantity_ordered))
            when 'cancel'
              @transaction.account_transactions.create(:account => somebody.account, :credit => -(sell_cost * quantity_ordered))
            when 'pre_supplier'
            when 'inorder'
              @transaction.account_transactions.create(:account => somebody.account, :credit => -(sell_cost * quantity_ordered))
            else
              raise "Позиция не может изменить свой статус с #{old_status} на #{new_status}"
            end


        when 'pre_supplier'
          case new_status
          when 'cancel'
            # TODO эта операция должна быть доступна администратору (по согласованию с снабженцем)'
            @transaction.account_transactions.create(:account => somebody.account, :credit => -(sell_cost * quantity_ordered))
          when 'pre_supplier'
          when 'post_supplier'
            @transaction.account_transactions.create(:account => supplier.account, :credit => (buy_cost * quantity_ordered))
          when 'incart'
            @transaction.account_transactions.create(:account => somebody.account, :credit => -(sell_cost * quantity_ordered))
          when 'inorder'
            @transaction.account_transactions.create(:account => somebody.account, :credit => -(sell_cost * quantity_ordered))
          else
            raise "Позиция не может изменить свой статус с #{old_status} на #{new_status}"
          end


        when 'post_supplier'
          case new_status
          when 'pre_supplier'
            @transaction.account_transactions.create(:account => supplier.account, :credit => -(buy_cost * quantity_ordered))
          when 'cancel'
            # TODO эта операция должна быть доступна администратору (по согласованию с снабженцем)'
            @transaction.account_transactions.create(:account => somebody.account, :credit => -(sell_cost * quantity_ordered))
            @transaction.account_transactions.create(:account => supplier.account, :credit => -(buy_cost * quantity_ordered))
          when 'stock'
            @transaction.account_transactions.create(:account => supplier.account, :credit => -(buy_cost * quantity_ordered), :debit => -(buy_cost * quantity_ordered))
          else
            raise "Позиция не может изменить свой статус с #{old_status} на #{new_status}"
          end

        when 'stock'
          case new_status
          when 'cancel'
            # TODO эта операция должна быть доступна администратору (по согласованию с снабженцем)'
            @transaction.account_transactions.create(:account => somebody.account, :credit => -(sell_cost * quantity_ordered))
          when 'pre_supplier'
            @transaction.account_transactions.create(:account => supplier.account, :debit => (buy_cost * quantity_ordered) )
          when 'complete'
            @transaction.account_transactions.create(:account => somebody.account, :credit => -(sell_cost * quantity_ordered), :debit => -(sell_cost * quantity_ordered))
          else
            raise "Позиция не может изменить свой статус с #{old_status} на #{new_status}"
          end

        when 'complete'
          case new_status
          when 'cancel'
            # WTF? TODO эта операция должна быть доступна администратору (по согласованию с снабженцем)'
            # Это когда товар выдали, а клиент принес его обратно. По нему ставится отказ. (Вроде логично) Тогда клиенту возвращаются деньги
            @transaction.account_transactions.create(:account => somebody.account, :debit => (sell_cost * quantity_ordered))
            #user.account(true).credit -= sell_cost * quantity_ordered
            #user.save
          when 'stock'
            @transaction.account_transactions.create(:account => somebody.account, :credit => (sell_cost * quantity_ordered), :debit => (sell_cost * quantity_ordered))
          else
            raise "Позиция не может изменить свой статус с #{old_status} на #{new_status}"
          end

        # TODO !!! Необходимо разрешить возвращать только в статус, который был ранее. Сейчас например можно сделать отказ из статуса
        # 'В корзине', а потом возврат из этого в статус, в котором продукт еще не был ранее, например в 'Получен'
        when 'cancel'
          case new_status
            when 'incart'
            when 'inorder'
            when 'ordered'
              @transaction.account_transactions.create(:account => somebody.account, :credit => (sell_cost * quantity_ordered))
            when 'pre_supplier'
              @transaction.account_transactions.create(:account => somebody.account, :credit => (sell_cost * quantity_ordered))
            when 'post_supplier'
              @transaction.account_transactions.create(:account => somebody.account, :credit => (sell_cost * quantity_ordered))
              @transaction.account_transactions.create(:account => supplier.account, :credit => (buy_cost * quantity_ordered))
            when 'stock'
              @transaction.account_transactions.create(:account => somebody.account, :credit => (sell_cost * quantity_ordered))
            when 'complete'
              @transaction.account_transactions.create(:account => somebody.account, :debit => -(sell_cost * quantity_ordered))
            else
              raise "Позиция не может изменить свой статус с #{old_status} на #{new_status}"
          end
      end

    # Если не происходила смена статуса
    else

      # TODO необходимо доработать в контроллере вопрос уведомления покупателя
      if sell_cost_changed? || quantity_ordered_changed?
        if ["ordered", "pre_supplier", "post_supplier", "stock"].include? status
          @transaction.account_transactions.create(:account => somebody.account, :credit => ( (sell_cost * quantity_ordered) - (sell_cost_was * quantity_ordered_was) ))
        elsif ["incart", "inorder"].include? status
        elsif ["complete"].include? status
          @transaction.account_transactions.create(:account => somebody.account, :debit => -( (sell_cost * quantity_ordered) - (sell_cost_was * quantity_ordered_was) ))
        else # cancel
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
          @transaction.account_transactions.create(:account => supplier.account, :credit => ( (buy_cost * quantity_ordered) - (buy_cost_was * quantity_ordered_was) ))
        elsif ["incart", "inorder", "ordered", "pre_supplier"].include? status
        elsif ["stock", "complete"].include? status
          @transaction.account_transactions.create(:account => supplier.account, :debit => -( (buy_cost * quantity_ordered) - (buy_cost_was * quantity_ordered_was) ))
        else # cancel
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

    # У новых товаров (без явно выставленного статуса {разобраться еще позже с этой категорией. 
    # Это разбитие товара, может быть еще какие-то (уже не так, у перезаказанных товаров сделал такой же статус, как и разбиваемого до перевода его в статус отказ
    # )}) статус по-умолчанию - в корзине
    if self.status == nil
      self.status = "incart"
    end


    # Если есть родительский товар, то необходимо у текущего 
    # выставить такого же пользователя, как и у родительского
    if product present?
      self.somebody = product.somebody
    end

  end

  def to_label
    "#{catalog_number} (#{cached_brand})"
  end







  # Можно перезаказать только отказанный товар (или если он удален - ситуация с split)
  before_validation do
    if product.present? && product.status != 'cancel' && !product.destroyed?
      errors.add(:base, 'Невозможно перезаказать товар, пока по нему не выставлен отказ.')
      return false
    end
  end


end
