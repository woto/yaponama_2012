class Admin::Products::PostSupplierController < Admin::ProductsController

  before_filter do 
    @products = products_user_order_tab_scope( Product.scoped, 'checked' )

    if @products.blank?
      redirect_to :back, :alert => "None products selected" and return
    end

    unless @products.all?{|p| ['pre_supplier', 'post_supplier'].include? p.status}
      redirect_to :back, :alert => 'At least one product not in status pre_supplier or post_supplier'
    end
  end


  def index
  end


  def create
    supplier = Supplier.where(:id => params[:supplier_id]).first

    if supplier.blank?
      redirect_to :back, :alert => "Please choose supplier" and return
    end

    @products.each do |product|
      product.supplier = supplier
      product.status = 'post_supplier'
      product.status_will_change!
      unless product.save
        redirect_to :back, :alert => product.errors.full_messages and return
      end
    end

    redirect_to_relative_path('post_supplier')

  end


end
