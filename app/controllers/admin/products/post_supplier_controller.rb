# encoding: utf-8

class Admin::Products::PostSupplierController < Admin::ProductsController

  before_filter do 
    begin

      @products = products_user_order_tab_scope( Product.scoped, 'checked' )
      products_any_checked_validation
      products_all_statuses_validation ['pre_supplier', 'post_supplier']

    rescue ValidationError => e
      redirect_to :back, :alert => e.message
    end

  end


  def index
  end


  def create
    supplier = Supplier.where(:id => params[:supplier_id]).first

    if supplier.blank?
      redirect_to :back, :alert => "Пожалуйста выберите поставщика." and return
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
