class Admin::Products::SplitController < Admin::ProductsController

  before_filter do 
    @products = products_user_order_tab_scope( Product.scoped, 'checked' )

    if @products.blank?
      redirect_to :back, :alert => "None products selected" and return
    end

    if @products.first.quantity_ordered <= 1
      redirect_to :back, :alert => "Can not split 1 ordered product" and return
    end

    if @products.size > 1
      redirect_to :back, :alert => "Can not split more than one product at once" and return
    end

  end

  # Keep it for running controller filters
  def index
    session[:return_url] = view_context.url_for(:back)
  end

  def update
    product = @products.first
    quantity = params[:quantity].to_i

    if quantity.to_i >= product.quantity_ordered
      redirect_to :back, :alert => "Can not split because of bad quantity entered" and return
    end

    p1 = @products.first.dup
    p2 = @products.first.dup

    p1.product = p2.product = product

    p1.quantity_ordered = quantity
    p2.quantity_ordered = product.quantity_ordered - quantity

    ActiveRecord::Base.transaction do
      p1.save
      p2.save

      # Run callbacks, but don't validate
      product.update_attribute(:status, "cancel")
    end

    redirect_to(session[:return_url])

  end

end
