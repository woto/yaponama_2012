# encoding: utf-8

class Products::CompleteController < ApplicationController
  include ProductsConcern
  include GridConcern

  before_action :set_grid

  before_filter do 
    begin

      Rails.application.routes.recognize_path params[:return_path]
      @items = products_user_order_tab_scope( @items, 'checked' )
      products_any_checked_validation
      products_all_statuses_validation ['stock', 'cancel']

    rescue ValidationError => e
      redirect_to :back, :alert => e.message
    end

  end


  def index
  end


  def create

    ActiveRecord::Base.transaction do
      @items.each do |item|
        item.status = 'complete'
        unless item.save
          redirect_to :back, :alert => item.errors.full_messages and return
        end
      end

    end

    redirect_to_relative_path('complete')

  end

end
