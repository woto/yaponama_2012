class Product < ActiveRecord::Base
  include PingCallback

  before_save :process_before_save
  before_destroy :process_before_destroy

  # Виртуальные аттрибуты
  attr_accessor :delivery_id, :delivery_cost
  attr_accessible :delivery_id, :delivery_cost

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
  has_many :products

  attr_accessible :notes, :notes_invisible, :max_days, :min_days, :probability, :quantity_available, :quantity_ordered, :status, :user_id, :order_id, :created_at, :updated_at

  attr_accessible :supplier_id

  before_save :set_relational_attributes

  def set_relational_attributes
    if self.order.present?
      self.user = self.order.user
    end
  end

  def process_before_save

    if self.changes["status"]
      old_status = self.changes["status"][0]
      new_status = self.changes["status"][1]

      case old_status

        when 'incart'
          case new_status
            when 'inorder'
            when 'cancel'
            else
              raise 'can not'
              #errors.add(:status, 'Products in cart in status "incart" can only change self status on "inorder" i.e. placed in order, or be destroyed')
              return false
          end


        when 'inorder'
          case new_status
            when 'cancel'
            when 'incart'
            else
              raise 'can not'
          end


        when 'ordered'
          raise '1'
          #case new_status
          #  when 'cancel'
          #    user.account.debit -= sell_cost * quantity_ordered
          #    user.save
          #  else
          #    raise 'can\'t'
          #  end
         
        when 'pre_supplier'
          raise '2'
        

        when 'post_supplier'
          raise '3'


        when 'stock'
          raise '4'
          #case new_status
          #  when 'cancel'
          #    user.account.debit -= sell_cost * quantity_ordered
          #  when 'complete'
          #    #user.account.debit -= sell_cost * quantity_ordered
          #    #user.account.credit -= (sell_cost * quantity_ordered) * prepayment_percent / 100
          #    #user.save
          #    raise 'right count the money'
          #  else
          #    raise '"stock" status can be changed only to "cancel" or "complete"'
          #end


        when 'complete'
          raise '5'


        when 'cancel'
          raise '6'
        end

      end
  end

  def process_before_destroy
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
