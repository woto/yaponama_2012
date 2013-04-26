# encoding: utf-8

class Admin::Products::PostSupplierController < Products::PostSupplierController
  include Admined
  include ProductsConcern

  before_filter do 
    begin

      Rails.application.routes.recognize_path params[:return_path]
      @items = products_user_order_tab_scope( @items, 'checked' )
      products_any_checked_validation
      products_all_statuses_validation ['pre_supplier', 'post_supplier', 'stock', 'cancel']

    rescue ValidationError => e
      redirect_to params[:return_path], :alert => e.message
    end

  end


  def index
  end


  def create
    supplier = Supplier.where(:id => params[:supplier_id]).first

    @items.each do |item|
      if ['stock', 'cancel'].include? item.status
        unless item.supplier == supplier
          redirect_to :back, :alert => "Отменить операцию можно только выбрав именно того же самого поставщика у которого был осуществлен заказ." and return
        end
      end
    end

    if supplier.blank?
      redirect_to :back, :alert => "Пожалуйста выберите поставщика." and return
    end

    @items.each do |item|
      item.supplier = supplier
      item.status = 'post_supplier'
      unless item.save
        redirect_to params[:return_path], :alert => item.errors.full_messages and return
      end
    end

    redirect_to_relative_path('post_supplier')

  end
end
