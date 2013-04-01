class ProductTransaction < ActiveRecord::Base
  include BelongsToCreator
  include BelongsToUser
  belongs_to :product
  has_many :account_transactions
end
