class Admin::Products::CancelController < Admin::ProductsController

  before_filter do 
    @products = products_user_order_tab_scope( Product.scoped, 'checked' )

    if @products.blank?
      redirect_to :back, :alert => "None products selected" and return
    end
  end


  def index
    session[:return_url] = view_context.url_for(:back)
  end


  def update
    @products.each do |product|
      product.status = 'cancel'
      unless product.save
        redirect_to :back, :alert => product.errors.full_messages and return
      end
    end

    redirect_to_relative_path('cancel')

  end
end
