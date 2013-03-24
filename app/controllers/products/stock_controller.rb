# encoding: utf-8

class Products::StockController < ApplicationController
  include ProductsHelper

  before_filter do 
    begin

      Rails.application.routes.recognize_path params[:return_path]
      @products = products_user_order_tab_scope( Product.order("updated_at DESC"), 'checked' )
      products_any_checked_validation
      products_all_statuses_validation ['post_supplier', 'complete', 'cancel']

    rescue ValidationError => e
      redirect_to :back, :alert => e.message
    end

  end


  def index
  end


  def create

    ActiveRecord::Base.transaction do
      @products.each do |product|
        product.status = 'stock'
        unless product.save
          redirect_to :back, :alert => product.errors.full_messages and return
        end
      end

    end

    redirect_to_relative_path('stock')

  end

end
