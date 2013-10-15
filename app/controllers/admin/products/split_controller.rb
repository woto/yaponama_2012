# encoding: utf-8

class Admin::Products::SplitController < ApplicationController #< Products::SplitController
  include Admin::Admined
  include ProductsConcern

  before_filter do 
    begin

      Rails.application.routes.recognize_path params[:return_path]
      @items = @items.selected(@grid.item_ids)
      any_checked_validation
      one_checked_validation
      products_all_statuses_validation ['incart', 'inorder', 'ordered', 'pre_supplier', 'post_supplier', 'stock', 'complete']

      if @items.first.quantity_ordered <= 1
        raise ValidationError.new "Невозможно разбить позицию состоящую из одного товара."
      end

    rescue ValidationError => e
      redirect_to params[:return_path], :alert => e.message
    end

  end


  # Keep it for running controller filters
  def index
  end


  def create
    item = @items.first
    quantity = params[:quantity].to_i

    if quantity.to_i < 1 || quantity.to_i >= item.quantity_ordered
      redirect_to :back, :alert => "Разбитие позиции не удалось, т.к. введено не корректное значение для первой партии. Число первой партии не может быть более #{item.quantity_ordered.to_i - 1}." and return
    end

    p1 = @items.first.dup
    p2 = @items.first.dup

    p1.product = p2.product = item 

    p1.quantity_ordered = quantity
    p2.quantity_ordered = item.quantity_ordered - quantity

    ActiveRecord::Base.transaction do
      # Run callbacks, but don't validate
      item.update_attribute(:status, "cancel")

      p1.save
      p2.save
    end

    redirect_to params[:return_path], :notice => "Товар успешно разбит на две партии. Первая - #{p1.quantity_ordered} шт., вторая - #{p2.quantity_ordered} шт."

  end

end
