# encoding: utf-8
#
class Product < ActiveRecord::Base
  include BelongsToUser
  include BelongsToSupplier
  include BelongsToCreator

  # Продукты по которым ожидается движение
  scope :active, -> { where("STRPOS(?, products.status) > 0", "ordered,pre_supplier,post_supplier,stock") }

  def self.summa
    sum("sell_cost * quantity_ordered").to_d
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

  has_many :product_transactions

  before_save :process_before_save

  def process_before_save

    if changes.present?
      # TODO
      # Почему-то если сохранить заказ (менял стоимость доставки заказа)
      # сохраняется и (уже сохраненный) product
      product_transaction = product_transactions.build
      h = {}
      self.changes.map{|k,v| h["log_#{k}"] = v[1]}
      # TODO проверить, раньше было update_attributes
      product_transaction.assign_attributes(h)
    end

    if self.changes["status"]
      old_status = self.changes["status"][0]
      new_status = self.changes["status"][1]

      case old_status

        # TODO этого ранее не было, сюда попадают новые товары (после разделения товаров и может быть еще какие-то :\)
        #
        # TODO случайно обнаружил что он совпадает с cancel, вроде это и логично, сравнить diff'ом и объединить если так
        when nil
          case new_status
            when 'incart'
            when 'inorder'
            when 'ordered'
              product_transaction.money_transactions.build(:account => user.account, :credit => (sell_cost * quantity_ordered))
            when 'pre_supplier'
              product_transaction.money_transactions.build(:account => user.account, :credit => (sell_cost * quantity_ordered))
            when 'post_supplier'
              product_transaction.money_transactions.build(:account => user.account, :credit => (sell_cost * quantity_ordered))
              product_transaction.money_transactions.build(:account => supplier.account, :credit => (buy_cost * quantity_ordered))
            when 'stock'
              product_transaction.money_transactions.build(:account => user.account, :credit => (sell_cost * quantity_ordered))
            when 'complete'
              product_transaction.money_transactions.build(:account => user.account, :debit => -(sell_cost * quantity_ordered))
            when 'cancel'
              raise "Позиция не может быть разбита в статусе #{new_status}"
          end

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
              product_transaction.money_transactions.build(:account => user.account, :credit => sell_cost * quantity_ordered)
            else
              raise "Позиция не может изменить свой статус с #{old_status} на #{new_status}"
          end


        when 'ordered'
          case new_status
            when 'incart'
              product_transaction.money_transactions.build(:account => user.account, :credit => -(sell_cost * quantity_ordered))
            when 'cancel'
              product_transaction.money_transactions.build(:account => user.account, :credit => -(sell_cost * quantity_ordered))
            when 'pre_supplier'
            when 'inorder'
              product_transaction.money_transactions.build(:account => user.account, :credit => -(sell_cost * quantity_ordered))
            else
              raise "Позиция не может изменить свой статус с #{old_status} на #{new_status}"
            end


        when 'pre_supplier'
          case new_status
          when 'cancel'
            # TODO эта операция должна быть доступна администратору (по согласованию с снабженцем)'
            product_transaction.money_transactions.build(:account => user.account, :credit => -(sell_cost * quantity_ordered))
          when 'pre_supplier'
          when 'post_supplier'
            product_transaction.money_transactions.build(:account => supplier.account, :credit => (buy_cost * quantity_ordered))
          when 'incart'
            product_transaction.money_transactions.build(:account => user.account, :credit => -(sell_cost * quantity_ordered))
          when 'inorder'
            product_transaction.money_transactions.build(:account => user.account, :credit => -(sell_cost * quantity_ordered))
          else
            raise "Позиция не может изменить свой статус с #{old_status} на #{new_status}"
          end


        when 'post_supplier'
          case new_status
          when 'pre_supplier'
            product_transaction.money_transactions.build(:account => supplier.account, :credit => -(buy_cost * quantity_ordered))
          when 'cancel'
            # TODO эта операция должна быть доступна администратору (по согласованию с снабженцем)'
            product_transaction.money_transactions.build(:account => user.account, :credit => -(sell_cost * quantity_ordered))
            product_transaction.money_transactions.build(:account => supplier.account, :credit => -(buy_cost * quantity_ordered))
          when 'stock'
            product_transaction.money_transactions.build(:account => supplier.account, :credit => -(buy_cost * quantity_ordered), :debit => -(buy_cost * quantity_ordered))
          else
            raise "Позиция не может изменить свой статус с #{old_status} на #{new_status}"
          end

        when 'stock'
          case new_status
          when 'cancel'
            # TODO эта операция должна быть доступна администратору (по согласованию с снабженцем)'
            product_transaction.money_transactions.build(:account => user.account, :credit => -(sell_cost * quantity_ordered))
          when 'post_supplier'
            product_transaction.money_transactions.build(:account => supplier.account, :credit => (buy_cost * quantity_ordered), :debit => (buy_cost * quantity_ordered) )
          when 'complete'
            product_transaction.money_transactions.build(:account => user.account, :credit => -(sell_cost * quantity_ordered), :debit => -(sell_cost * quantity_ordered))
          else
            raise "Позиция не может изменить свой статус с #{old_status} на #{new_status}"
          end

        when 'complete'
          case new_status
          when 'cancel'
            # WTF? TODO эта операция должна быть доступна администратору (по согласованию с снабженцем)'
            # Это когда товар выдали, а клиент принес его обратно. По нему ставится отказ. (Вроде логично) Тогда клиенту возвращаются деньги
            product_transaction.money_transactions.build(:account => user.account, :debit => (sell_cost * quantity_ordered))
            #user.account(true).credit -= sell_cost * quantity_ordered
            #user.save
          when 'stock'
            product_transaction.money_transactions.build(:account => user.account, :credit => (sell_cost * quantity_ordered), :debit => (sell_cost * quantity_ordered))
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
              product_transaction.money_transactions.build(:account => user.account, :credit => (sell_cost * quantity_ordered))
            when 'pre_supplier'
              product_transaction.money_transactions.build(:account => user.account, :credit => (sell_cost * quantity_ordered))
            when 'post_supplier'
              product_transaction.money_transactions.build(:account => user.account, :credit => (sell_cost * quantity_ordered))
              product_transaction.money_transactions.build(:account => supplier.account, :credit => (buy_cost * quantity_ordered))
            when 'stock'
              product_transaction.money_transactions.build(:account => user.account, :credit => (sell_cost * quantity_ordered))
            when 'complete'
              product_transaction.money_transactions.build(:account => user.account, :debit => -(sell_cost * quantity_ordered))
            else
              raise "Позиция не может изменить свой статус с #{old_status} на #{new_status}"
          end
      end

    # Если не происходила смена статуса
    else

      # При смене поставщика не присходит смена статуса
      # случай если меняется только поставщик post_supplier -> post_supplier
      if self.supplier_id_changed?
        ActiveRecord::Base.transaction do
          supplier_was = Supplier.find(changes["supplier_id"][0])
          product_transaction.money_transactions.build(:account => supplier_was.account, :credit => -(buy_cost * quantity_ordered))
          product_transaction.money_transactions.build(:account => supplier.account, :credit => (buy_cost * quantity_ordered))
        end
      end

      # TODO необходимо доработать в контроллере вопрос уведомления покупателя
      if sell_cost_changed? || quantity_ordered_changed?
        if ["ordered", "pre_supplier", "post_supplier", "stock"].include? status
          product_transaction.money_transactions.build(:account => user.account, :credit => ( (sell_cost * quantity_ordered) - (sell_cost_was * quantity_ordered_was) ))
        elsif ["incart", "inorder"].include? status
        elsif ["complete"].include? status
          product_transaction.money_transactions.build(:account => user.account, :debit => -( (sell_cost * quantity_ordered) - (sell_cost_was * quantity_ordered_was) ))
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
          product_transaction.money_transactions.build(:account => supplier.account, :credit => ( (buy_cost * quantity_ordered) - (buy_cost_was * quantity_ordered_was) ))
        elsif ["incart", "inorder", "ordered", "pre_supplier"].include? status
        elsif ["stock", "complete"].include? status
          product_transaction.money_transactions.build(:account => supplier.account, :debit => -( (buy_cost * quantity_ordered) - (buy_cost_was * quantity_ordered_was) ))
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

    if self.products.present? && self.status != 'cancel'
      errors.add(:base, 'Невозможно перезаказать товар, пока по нему не выставлен отказ.')
      return false
    end

  end

  def to_label
    catalog_number + " - " + manufacturer
  end

end
