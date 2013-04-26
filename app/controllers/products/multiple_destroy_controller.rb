# encoding: utf-8

class Products::MultipleDestroyController < ApplicationController
  include ProductsConcern

  before_filter do
    begin

      Rails.application.routes.recognize_path params[:return_path]
      @items = products_user_order_tab_scope( @items, 'checked' )
      products_any_checked_validation
      products_all_statuses_validation ['cancel']

    rescue ValidationError => e
      redirect_to params[:return_path], :alert => e.message
    end

  end

  def index 

    begin

      result = {}

      @items.each do |item|
        if item.destroy
          result = { :notice => "Товары(ы) успешно удалены." }
        else
          result = { :alert => "Невозможно удалить товар: #{item.errors[:base].to_s}" }
          break
        end
      end

      respond_to do |format|
        format.html { redirect_to :back, result }
        format.json { head :no_content }
      end

    rescue ValidationError => e
      redirect_to :back, :alert => e.message
    end

  end


end
