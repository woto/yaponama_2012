# encoding: utf-8

class Admin::Products::PostSupplierController < Admin::ProductsController

  before_filter do 
    begin

      Rails.application.routes.recognize_path params[:return_path]
      @products = products_user_order_tab_scope( Product.order("updated_at DESC"), 'checked' )
      products_any_checked_validation
      products_all_statuses_validation ['pre_supplier', 'post_supplier', 'stock', 'cancel']

    rescue ValidationError => e
      redirect_to :back, :alert => e.message
    end

  end


  def index
  end


  def create
    supplier = Supplier.where(:id => params[:supplier_id]).first

    @products.each do |product|
      if product.status == 'stock'
        unless product.supplier == supplier
          redirect_to :back, :alert => "Отменить операцию можно только выбрав именно того же самого поставщика у которого был осуществлен заказ." and return
        end
      end
    end

    if supplier.blank?
      redirect_to :back, :alert => "Пожалуйста выберите поставщика." and return
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
