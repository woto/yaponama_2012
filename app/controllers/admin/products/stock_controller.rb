class Admin::Products::StockController < Products::StockController
  include Admined
  include ProductsHelper
end
