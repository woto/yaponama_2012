class Admin::Products::OrderedController < Products::OrderedController
  include Admined
  include ProductsHelper
end
