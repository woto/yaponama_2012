class Admin::Products::PostSupplierController < Admin::ProductsController

  before_filter do 
    @products = products_user_order_tab_scope( Product.scoped, 'checked' )

    if @products.blank?
      redirect_to :back, :alert => "None products selected" and return
    end

    unless @products.all?{|product| product.status == 'pre_supplier'}
      redirect_to :back, :alert => 'At least one product not in status pre_supplier'
    end
  end


  def index
  end


  def update
    supplier = Supplier.where(:id => params[:supplier_id]).first

    if supplier.blank?
      redirect_to :back, :alert => "Please choose supplier" and return
    end

    @products.each do |product|
      product.supplier = supplier
      product.status = 'post_supplier'
      unless product.save
        redirect_to :back, :alert => product.errors.full_messages and return
      end
    end

    redirect_to_relative_path('post_supplier')

  end


end
