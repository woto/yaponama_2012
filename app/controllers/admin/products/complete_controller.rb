class Admin::Products::CompleteController < Products::CompleteController
  include Admined
  include ProductsHelper
end
