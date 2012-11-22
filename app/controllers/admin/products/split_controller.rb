# encoding: utf-8
#
class Admin::Products::SplitController < Admin::ProductsController

  before_filter do 
    @product = Product.find(params[:id])

    if @product.quantity_ordered <= 1
      redirect_to :back, :alert => "Невозможно разбить 1 единицу товара на 2 партии." and return
    end
  end

  def index
  end

  def update
    Rails.application.routes.recognize_path params[:return_path]

    split_quantity_ordered = params[:product][:split_quantity_ordered].to_i

    @p1 = @product.dup
    @p2 = @product.dup

    @p1.product = @p2.product = @product

    @p1.quantity_ordered = split_quantity_ordered
    @p2.quantity_ordered = @product.quantity_ordered - split_quantity_ordered

    ActiveRecord::Base.transaction do
      unless @product.update_attributes(params[:product].merge(:status => "cancel")) && @p1.save && @p2.save
        render 'index' and return
      end
    end

    redirect_to(params[:return_path], :notice => "Товар успешно разбит на 2 партии.")

  end

end
