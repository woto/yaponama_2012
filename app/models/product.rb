# encoding: utf-8
#
class Product < ActiveRecord::Base

  include PingCallback

  # Виртуальные аттрибуты
  attr_accessor :delivery_id, :delivery_cost
  attr_accessible :delivery_id, :delivery_cost

  # TODO remove later, when normalized situation around edit view product_fields
  attr_accessor :_destroy
  attr_accessible :_destroy

  # SPLIT
  attr_accessor :split_quantity_ordered
  attr_accessible :split_quantity_ordered

  validate :check_split_quantity_ordered, :on => :update, :if => Proc.new{|p| split_quantity_ordered}
  
  def check_split_quantity_ordered
    if @split_quantity_ordered.to_i < 1 || @split_quantity_ordered.to_i >= quantity_ordered
      errors.add(:split_quantity_ordered, "Wrong split_quantity_ordered value")
    end
  end
  # /SPLIT

  attr_accessible :catalog_number, :manufacturer, :short_name, :long_name
  validates :catalog_number, :manufacturer, :presence => true

  attr_accessible :buy_cost, :sell_cost
  validates :buy_cost, :numericality => { :greater_than => 0}
  validates :sell_cost, :numericality => { :greater_than => 0}

  validates :quantity_ordered, :numericality => { :greater_than_or_equal_to => 1, :only_integer => true }

  belongs_to :user, :validate => true
  validates :user, :presence => true

  belongs_to :order

  belongs_to :supplier

  belongs_to :product

  attr_accessible :products_attributes
  has_many :products, :dependent => :destroy
  accepts_nested_attributes_for :products, :allow_destroy => true

  attr_accessible :status
  validates :status, :inclusion => {:in => Rails.configuration.products_status.select{|k, v| v['real'] == true}.keys}

  scope :inwork, where("FIND_IN_SET(products.status, 'ordered,pre_supplier,post_supplier,stock')")
  #scope :inorder, where(:status => "inorder")

  attr_accessible :notes, :notes_invisible, :max_days, :min_days, :probability, :quantity_available, :quantity_ordered, :user_id, :order_id, :created_at, :updated_at

  attr_accessible :supplier_id

  #before_save :set_relational_attributes_save
  #
  #def set_relational_attributes_save
  #  if self.order.present?
  #    self.user = self.order.user
  #  end
  #end

  before_save :process_before_save

  def process_before_save

    # TODO check later
    ## Sell cost doesn't mutable
    #if self.persisted? && self.changes["sell_cost"]
    #  errors.add(:sell_cost, "Unable to change sell cost, make cancel and reorder")
    #  return false
    #end

    if self.changes["status"]
      old_status = self.changes["status"][0]
      new_status = self.changes["status"][1]

      case old_status

        when 'incart'
          case new_status
            when 'inorder'
            when 'cancel'
            else
              errors.add(:status, 'Product can not change status on this')
              return false
          end


        when 'inorder'
          case new_status
            when 'incart'
            when 'inorder'
            when 'cancel'
            when 'ordered'
              user.account.credit += sell_cost * quantity_ordered
              user.save
            else
              errors.add(:base, 'Product can not change status on this')
              return false
          end


        when 'ordered'
          case new_status
            when 'cancel'
              user.account.credit -= sell_cost * quantity_ordered
              user.save
            when 'pre_supplier'
            when 'inorder'
              user.account.credit -= sell_cost * quantity_ordered
              user.save
            else
              errors.add(:base, 'Product can not change status on this')
              return false
            end
         

        when 'pre_supplier'
          case new_status
          when 'cancel'
            user.account.credit -= sell_cost * quantity_ordered
            user.save
          when 'post_supplier'
            supplier.account.credit += buy_cost * quantity_ordered
            supplier.save
          else
            errors.add(:base, 'Product can not change status on this')
            return false
          end
        

        when 'post_supplier'
          case new_status
          when 'cancel'
            #user.account.credit -= sell_cost * quantity_ordered
            #supplier.account.credit -= buy_cost * quantity_ordered
            #user.save
            #supplier.save
          when 'stock'
            supplier.account.credit -= buy_cost * quantity_ordered
            supplier.save
          else
            errors.add(:base, 'Product can not change status on this')
            return false
          end
        when 'stock'
          case new_status
          when 'complete'
            user.account.credit -= sell_cost * quantity_ordered
            user.save
          when 'cancel'
          else
            errors.add(:base, 'Product can not change status on this')
            return false
          end

        when 'complete'
          case new_status
          when 'cancel'
          else
            errors.add(:base, 'Product can not change status on this')
            return false
          end

        when 'cancel'
          errors.add(:base, 'Product can not change status on this')
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

    debugger
    if self.order.present?
      self.user = self.order.user
      self.products.each do |product|
        product.order = self.order
        product.user = self.user
      end
    end

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

end
