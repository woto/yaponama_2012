# encoding: utf-8
#
class Admin::CashesController < ApplicationController
  include Admin::Admined
  
  def create
    respond_to do |format|
      if @resource.save
        format.html { redirect_to [:admin, @user], success: "Успешно внесено #{view_context.number_to_currency(@resource.debit)}" }
      else
        byebug
        format.html { render action: "new" }
      end
    end

  end

  def user_set
    @somebody = @user = User.find(params[:user_id]) if params[:user_id]
  end

  def somebody_set
  end

  def supplier_set
    @somebody = @supplier = Supplier.find(params[:supplier_id]) if params[:supplier_id]
  end

  def set_resource_class
    @resource_class = Cash
  end

end
