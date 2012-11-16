class Admin::Products::IncartController < Admin::ProductsController

  def index
    @products = products_user_order_tab_scope( Product.scoped, 'checked' )
  end

  def update
    @products = products_user_order_tab_scope( Product.scoped, 'checked' )
    @products.each do |product|
      product.status = 'incart'
      product.save
    end
  end

end
