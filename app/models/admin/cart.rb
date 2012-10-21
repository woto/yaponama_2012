class Admin::Cart < ActiveRecord::Base
  belongs_to :user
  attr_accessible :catalog_number, :manufacturer, :max_days, :min_days, :probability, :quantity, :user_id
end
