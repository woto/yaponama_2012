# encoding: utf-8

class Products::InorderController < ApplicationController
  include ProductsConcern
  include GridConcern

  before_action :set_grid

  before_filter do
    begin

      Rails.application.routes.recognize_path params[:return_path]
      @items = products_user_order_tab_scope( @items, 'checked' ) 
      products_any_checked_validation
      products_belongs_to_one_user_validation!
      products_all_statuses_validation ["incart", "inorder", "ordered", "pre_supplier", 'cancel']


    rescue ValidationError => e
      redirect_to params[:return_path], :alert => e.message and return
    end

  end


  def index
  end


  def order_select
    @order = Order.where(:id => params[:new_order_id]).first
    if @order.present? || params[:new_order_id] == 'new'
      redirect_to smart_route({:prefix => [:action], :postfix => [:products, :inorder]}, :id => ( (@order.present? && @order.persisted?) ? @order : 'new'), :user_id => params[:user_id], :order_id => params[:order_id], :primary_key => params[:primary_key], :return_path => params[:return_path]) and return
    else
      redirect_to smart_route({:postfix => [:products, :inorder, :index ]}, :user_id => params[:user_id], :order_id => params[:order_id], :return_path => params[:return_path], :primary_key => params[:primary_key]), :alert => 'Пожалуйста выберите имеющийся заказ или создайте новый' and return
    end
  end


  def action
    @order = Order.where(:id => params[:id]).first
    unless @order
      @order = Order.new
    end
  end

end
