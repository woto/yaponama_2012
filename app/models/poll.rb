class Poll < ActiveRecord::Base
  enum price: [:cheap, :normal, :expensive]
  enum awaiting: [:warehouse, :few_days, :min_price]
  enum reach: [:moscow_delivery, :pickups, :russia]
end
