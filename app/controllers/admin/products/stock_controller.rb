# encoding: utf-8

class Admin::Products::StockController < ApplicationController #< Products::StockController
  include Admin::Admined
  include ProductsConcern

  before_filter do 
    begin

      Rails.application.routes.recognize_path params[:return_path]
      any_checked_validation
      products_all_statuses_validation ['post_supplier', 'complete', 'cancel']

    rescue ValidationError => e
      redirect_to params[:return_path], :alert => e.message
    end

  end


  def index
  end


  def create

    ActiveRecord::Base.transaction do
      @items.each do |item|
        item.status = 'stock'
        unless item.save
          redirect_to params[:return_path], :alert => item.errors.full_messages and return
        end
      end

    end

    redirect_to_relative_path('stock')

  end

end
