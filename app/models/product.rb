class Product < ActiveRecord::Base
  include PingCallback

  # Виртуальные аттрибуты
  attr_accessor :delivery_id, :delivery_cost
  attr_accessible :delivery_id, :delivery_cost

  attr_accessible :catalog_number, :manufacturer, :short_name, :long_name
  validates :catalog_number, :manufacturer, :presence => true

  attr_accessible :buy_cost, :sell_cost
  validates :buy_cost, :numericality => { :greater_than => 0}
  validates :sell_cost, :numericality => { :greater_than => 0}

  validates :quantity_ordered, :numericality => { :greater_than_or_equal_to => 1 }

  belongs_to :user, :inverse_of => :products, :validate => true
  validates :user, :presence => true

  belongs_to :order, :inverse_of => :products_incart
  belongs_to :order, :inverse_of => :products_inorder
  belongs_to :order, :inverse_of => :products_ordered
  belongs_to :order, :inverse_of => :products

  belongs_to :supplier, :inverse_of => :products

  attr_accessible :notes, :notes_invisible, :max_days, :min_days, :probability, :quantity_available, :quantity_ordered, :status, :user_id, :order_id, :created_at, :updated_at

  attr_accessible :supplier_id

  before_save :set_relational_attributes

  def set_relational_attributes
    if self.order.present?
      self.user = self.order.user
    end
  end

  before_save :process_product_before_save

  def process_product_before_save
    if self.changes["status"]
      old_status = self.changes["status"][0]
      new_status = self.changes["status"][1]
      case old_status

        when 'incart'
          case new_status
            when 'inorder'
            else
              raise 'can\'tasdf asdf '
              #errors.add(:status, 'Products in cart in status "incart" can only change self status on "inorder" i.e. placed in order, or be destroyed')
              return false
          end

        when 'inorder'
          case new_status
            when 'ordered'
            when 'cancel'
            when 'incart'
            else
              raise 'can\'t afdafadf'
          end

        when 'ordered'
          case new_status
            when 'cancel'
              user.account.debit -= sell_cost * quantity_ordered
              user.save
            else
              raise 'can\'t'
            end
        when 'pre_supplier'
        when 'post_supplier'
        when 'stock'
          case new_status
            when 'cancel'
              user.account.debit -= sell_cost * quantity_ordered
            when 'complete'
              #user.account.debit -= sell_cost * quantity_ordered
              #user.account.credit -= (sell_cost * quantity_ordered) * prepayment_percent / 100
              #user.save
              raise 'right count the money'
            else
              raise '"stock" status can be changed only to "cancel" or "complete"'
          end
        when 'complete'
          raise '"complete" status can\'t be modified'
        when 'cancel'
          raise 'todo'
        end
      end
  end

  before_destroy :process_product_before_destroy

  def process_product_before_destroy
    unless ["incart", "inorder", "ordered"].include? status
      errors.add(:base, "Not in status incart, inorder or ordered.")
      return false
    end

    if ["ordered"].include? status
      user.account.debit -= sell_cost * quantity_ordered
      user.save
    end
  end

end
