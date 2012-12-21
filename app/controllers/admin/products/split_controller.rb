# encoding: utf-8

class Admin::Products::SplitController < Admin::ApplicationController
  include Admin::AddAdminViewPathHelper
  include ProductsHelper

  before_filter do 
    begin

      Rails.application.routes.recognize_path params[:return_path]
      @products = products_user_order_tab_scope( Product.order("updated_at DESC"), 'checked' )
      products_any_checked_validation
      products_all_statuses_validation ['incart', 'inorder', 'ordered', 'pre_supplier', 'post_supplier', 'stock', 'complete']
      products_only_one_validation

      if @products.first.quantity_ordered <= 1
        raise ValidationError.new "Невозможно разбить позицию состоящую из одного товара."
      end

    rescue ValidationError => e
      redirect_to :back, :alert => e.message
    end

  end


  # Keep it for running controller filters
  def index
  end


  def create
    product = @products.first
    quantity = params[:quantity].to_i

    if quantity.to_i < 1 || quantity.to_i >= product.quantity_ordered
      redirect_to :back, :alert => "Разбитие позиции не удалось, т.к. введено не корректное значение для первой партии. Число первой партии не может быть более #{product.quantity_ordered.to_i - 1}." and return
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

    redirect_to params[:return_path], :notice => "Товар успешно разбит на две партии. Первая - #{p1.quantity_ordered} шт., вторая - #{p2.quantity_ordered} шт."

  end

end
