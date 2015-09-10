class ProductsController < ApplicationController

  include ProductsSearch

  #ORDER_STEPS = %w[order delivery postal_address phone name notes]
  #before_action do
  #  binding.pry
  #end
  
  skip_before_filter :find_resource, only: [:incart, :inorder, :inorder_action, :ordered, :pre_supplier, :post_supplier, :post_supplier_action, :stock, :complete, :cancel, :multiple_destroy]

  def new
    respond_to do |format|
      format.html do

        if params[:catalog_number].present?
          catalog_number = params[:catalog_number]
        elsif params[:product_id].present?
          catalog_number = Product.find(params[:product_id]).catalog_number
        end

        search catalog_number, params[:manufacturer], params[:replacements]
      end
    end
  end

  def edit
    respond_to do |format|
      format.html do

        if params[:catalog_number].present?
          catalog_number = params[:catalog_number]
        elsif params[:id].present?
          catalog_number = Product.find(params[:id]).catalog_number
        end

        search catalog_number, params[:manufacturer], params[:replacements]
      end
    end
    
  end

  def create

    #search @resource.catalog_number, nil, nil

    respond_to do |format|
      if @resource.save
        format.html { redirect_to(polymorphic_path([:status, *jaba3, :products], {status: 'incart'}), notice: "Товар #{@resource.to_label} успешно добавлен в корзину.") }
      else
        format.html { render action: 'new' }
      end
    end
  end

  def update
    respond_to do |format|
      if @resource.save
        format.html { redirect_to(polymorphic_path([:status, *jaba3, :products], {status: 'incart'}), notice: "Товар #{@resource.to_label} успешно изменен.") }
      else
        format.html { render action: 'new' }
      end
    end
  end

  private

  def set_resource_class
    @resource_class = Product
  end

end
