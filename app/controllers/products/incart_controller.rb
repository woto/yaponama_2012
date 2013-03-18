# encoding: utf-8

class Products::IncartController < ApplicationController
  before_action :set_user
  include ProductsHelper
  include Admin::AddAdminViewPathHelper

  before_filter do 
    begin

      Rails.application.routes.recognize_path params[:return_path]
      @products = products_user_order_tab_scope( Product.order("updated_at DESC"), 'checked' ) 
      products_any_checked_validation
      products_all_statuses_validation ['incart', 'inorder', 'ordered', 'pre_supplier', 'cancel']

    rescue ValidationError => e
      redirect_to :back, :alert => e.message
    end

  end


  def index
  end

  def create

    @products.each do |product|
      product.status = 'incart'
      # TODO надо/не надо?
      #product.order = nil
      unless product.save
        redirect_to :back, :alert => product.errors.full_messages and return
      end
    end

    redirect_to_relative_path('incart')

  end


  private

  def set_user
    @user = current_user
  end

end
