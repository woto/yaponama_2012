# encoding: utf-8
#
class Split

  include ActiveModel::Model
  include ActiveModel::Dirty
  include ActiveModel::Validations::Callbacks
  include ActiveModel::SecurePassword

  attr_accessor :product_id
  attr_accessor :quantity

  validates :quantity, numericality: { only_integer: true, greater_than: 0, less_than: Proc.new{ |me| Product.find(me.product_id).quantity_ordered} }

  def save
    ActiveRecord::Base.transaction do
      if valid?
        product = Product.find(product_id)
        quantity = self.quantity.to_i

        p1 = product.dup
        p2 = product.dup

        p1.product = p2.product = product

        p1.quantity_ordered = quantity
        p2.quantity_ordered = product.quantity_ordered - quantity

        product.destroy!

        p1.save!
        p2.save!
      end
    end
  end

end
