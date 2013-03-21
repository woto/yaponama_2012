class Admin::OrdersController < OrdersController
  include Admined
  include ProductsHelper
end
