#encoding: utf-8

class SearchesController < ApplicationController

  include ProductsSearch

  def index
    if search params[:catalog_number], params[:manufacturer], params[:replacements]
      respond_to do |format|
        format.html { render "index" }
        format.js { render "index" }
      end
    end

  end

  private

  def user_set
    @somebody = @user = User.find(current_user)
  end

  def set_resource_class
  end

  def somebody_set
  end

  def supplier_set
  end
end
