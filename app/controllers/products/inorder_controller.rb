# encoding: utf-8

class Products::InorderController < ApplicationController
  include ProductsConcern

  before_action :set_grid

  before_filter do
    begin

      Rails.application.routes.recognize_path params[:return_path]
      @items = products_user_order_tab_scope( @items, 'checked' ) 
      products_any_checked_validation
      products_belongs_to_one_user_validation!
      products_all_statuses_validation ["incart", "inorder", "ordered", "pre_supplier", 'cancel']

    rescue ValidationError => e
      redirect_to params[:return_path], :alert => e.message
    end

  end


  def index
  end

  def order_select

    # Если выбрали новый заказ
    if params[:id] == '-1'

      @order = Order.where(:id => params[:id]).first

      redirect_to smart_route({:prefix => [:action], :postfix => [:products, :inorder_index]}, :user_id => params[:user_id], :order_id => params[:order_id], :primary_key => params[:primary_key], :return_path => params[:return_path]) and return

    # Если не выбрали ничего из списка
    elsif params[:id].blank?

      redirect_to smart_route({:postfix => [:products, :inorder_index]}, :user_id => params[:user_id], :order_id => params[:order_id], :primary_key => params[:primary_key], :return_path => params[:return_path]), :alert => 'Пожалуйста выберите имеющийся заказ или создайте новый' and return

    # В существующий заказ
    else

      ActiveRecord::Base.transaction do
        @order = Order.find(params[:id])
        @order.update_order_on_products(@items)
      end

      redirect_to smart_route({:postfix => [:products]}, :user_id => @order.user_id, :order_id => @order.id), :notice => "Товар(ы) были успешно добавлены в существующий заказ."

    end
  end

  def action
    if request.post?
      ActiveRecord::Base.transaction do
        @order = Order.new(order_params)
        @order.user = @items.first.user
        if @order.save
          @order.update_order_on_products(@items)
          redirect_to smart_route({:postfix => [:products]}, :user_id => @order.user_id, :order_id => @order.id), :notice => "Заказ успешно создан."
        end
      end
    else
      @order = Order.where(:id => params[:id]).first
      unless @order
        @order = Order.new
      end
    end
  end

  def order_params
    params[:order].permit!
  end

end
