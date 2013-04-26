# encoding: utf-8

class Products::EditController < ApplicationController
  include ProductsConcern

  before_filter do
    begin

      Rails.application.routes.recognize_path params[:return_path]
      @items = products_user_order_tab_scope( @items, 'checked' )
      products_any_checked_validation
      products_only_one_validation
      products_all_statuses_validation ['incart', 'inorder', 'ordered', 'pre_supplier', 'post_supplier', 'stock', 'complete', 'cancel']

    rescue ValidationError => e
      redirect_to params[:return_path], :alert => e.message
    end

  end


  def index
  end


  def create
    item = @items.first

    respond_to do |format|
      if item.update_attributes(product_params)
        format.html { redirect_to(params[:return_path], :notice => "Позиция успешно изменена.") }
        format.json { head :no_content }
      else
        format.html { render action: "index" }
        format.json { render json: item.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def product_params
    params.require(:product).permit!
  end

end
