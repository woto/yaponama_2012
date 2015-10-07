class Product < ActiveRecord::Base

  include BelongsToCreator
  include BelongsToUser
  include Concerns::BrandAttributes

  enum status: [:incart, :inorder, :ordered, :pre_supplier, :post_supplier, :stock, :complete, :cancel]

  def self.summa
    sum("sell_cost * quantity_ordered").to_d
  end

  validates :catalog_number, :presence => true
  validates :brand, :presence => true

  validates :buy_cost, :numericality => { :greater_than => 0}
  validates :sell_cost, :numericality => { :greater_than => 0}

  validates :quantity_ordered, :numericality => { :greater_than_or_equal_to => 1, :only_integer => true }

  belongs_to :order

  def to_label
    "#{catalog_number} (#{brand.name})"
  end

  validate do
    if brand.try(:sign)
      errors[:brand] << 'Нельзя указывать производителя, у которого есть родитель.'
    end
  end

end
