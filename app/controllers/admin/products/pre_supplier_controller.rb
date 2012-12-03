class Admin::Products::PreSupplierController < Admin::ProductsController

  before_filter do 
    @products = products_user_order_tab_scope( Product.scoped, 'checked' )

    if @products.blank?
      redirect_to :back, :alert => "None products selected" and return
    end

    unless @products.all?{|product| product.status == 'ordered'}
      redirect_to :back, :alert => 'At least one product not in status ordered'
    end
  end


  def index
  end


  def create
    @products.each do |product|
      product.status = 'pre_supplier'
      product.status_will_change!
      unless product.save
        redirect_to :back, :alert => product.errors.full_messages and return
      end
    end

    redirect_to_relative_path('pre_supplier')

  end
end
