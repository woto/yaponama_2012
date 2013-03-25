class ProductTransaction < ActiveRecord::Base
  belongs_to :product
  has_many :money_transactions
end
