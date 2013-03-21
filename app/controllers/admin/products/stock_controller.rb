class Admin::Products::StockController < Products::StockController
  include ProductsHelper
  include Admined
end
