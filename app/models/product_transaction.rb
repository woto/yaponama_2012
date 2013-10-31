class ProductTransaction < ActiveRecord::Base
  include BelongsToCreator
  include BelongsToSomebody
  has_many :account_transactions
  #belongs_to :product, :inverse_of => :product_transactions
end
