class ProductTransaction < ActiveRecord::Base
  belongs_to :product

  attr_accessible :log_buy_cost, :log_catalog_number, :log_created_at, :log_long_name, :log_manufacturer, :log_max_days, :log_min_days, :log_notes, :log_notes_invisible, :log_order_id, :log_probability, :log_product_id, :log_quantity_available, :log_quantity_ordered, :log_sell_cost, :log_short_name, :log_status, :log_supplier_id, :log_transaction_product_id, :log_updated_at, :log_user_id
end
