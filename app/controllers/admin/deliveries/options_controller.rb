# encoding: utf-8
#
class Admin::Deliveries::OptionsController < ApplicationController
  include Admin::Admined
  include GridOption

  skip_before_filter :set_grid, only: [:new, :create, :edit, :update, :show, :destroy]

  ## PATCH/PUT /deliveries/options/1
  ## PATCH/PUT /deliveries/options/1.json
  #def update
  #  respond_to do |format|
  #    if @resource.update(resource_params)
  #      format.html { redirect_to @resource, notice: 'Option was successfully updated.' }
  #      format.json { head :no_content }
  #    else
  #      format.html { render action: 'edit' }
  #      format.json { render json: @resource.errors, status: :unprocessable_entity }
  #    end
  #  end
  #end

  ## DELETE /deliveries/options/1
  ## DELETE /deliveries/options/1.json
  #def destroy
  #  @resource.destroy
  #  respond_to do |format|
  #    format.html { redirect_to deliveries_options_url }
  #    format.json { head :no_content }
  #  end
  #end

  private

  def set_resource_class
    @resource_class = Deliveries::Option
  end

  def user_set
    @somebody = @user = User.find(params[:user_id]) if params[:user_id]
  end

  def somebody_set
  end

  def supplier_set
    @somebody = @supplier = Supplier.find(params[:supplier_id]) if params[:supplier_id]
  end


  def user_get
  end

  def supplier_get
  end

  def somebody_get
  end

end
