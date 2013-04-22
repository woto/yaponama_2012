# encoding: utf-8

class Products::IncartController < ApplicationController
  include ProductsConcern
  include GridConcern

  before_action :set_grid


  before_filter do 
    begin

      Rails.application.routes.recognize_path params[:return_path]
      @items = products_user_order_tab_scope( @items, 'checked' ) 
      products_any_checked_validation
      products_all_statuses_validation ['incart', 'inorder', 'ordered', 'pre_supplier', 'cancel']

    rescue ValidationError => e
      redirect_to params[:return_path], :alert => e.message
    end

  end


  def index
  end

  def create

    @items.each do |item|
      item.status = 'incart'
      # TODO надо/не надо?
      #item.order = nil
      unless item.save
        redirect_to params[:return_path], :alert => item.errors.full_messages and return
      end
    end

    redirect_to_relative_path('incart')

  end

end
