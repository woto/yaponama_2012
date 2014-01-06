# encoding: utf-8
#
class Admin::SuppliersController < ApplicationController
  include Admin::Admined
  include GridSupplier
  #include GetUserFromResourceDummy

  skip_before_filter :set_grid, :only => [:new, :create, :edit, :update, :show, :destroy]

  ## GET /admin/suppliers/1
  ## GET /admin/suppliers/1.json
  #def show
  #  @supplier = Supplier.find(params[:id])

  #  respond_to do |format|
  #    format.html # show.html.erb
  #    format.json { render json: @supplier }
  #  end
  #end

  ## GET /admin/suppliers/new
  ## GET /admin/suppliers/new.json
  #def new
  #  @supplier = Supplier.new

  #  if @supplier.account.blank?
  #    @supplier.account = Account.new
  #  end

  #  respond_to do |format|
  #    format.html # new.html.erb
  #    format.json { render json: @supplier }
  #  end
  #end

  ## GET /admin/suppliers/1/edit
  #def edit
  #  @supplier = Supplier.find(params[:id])
  #end

  def create_resource
    @resource = @resource_class.new(resource_params)
    @resource.build_account
  end

  ## PUT /admin/suppliers/1
  ## PUT /admin/suppliers/1.json
  #def update
  #  @supplier = Supplier.find(params[:id])

  #  respond_to do |format|
  #    if @supplier.update_attributes(supplier_params)
  #      format.html { redirect_to admin_supplier_path(@supplier), notice: 'Supplier was successfully updated.' }
  #      format.json { head :no_content }
  #    else
  #      format.html { render action: "edit" }
  #      format.json { render json: @supplier.errors, status: :unprocessable_entity }
  #    end
  #  end
  #end

  ## DELETE /admin/suppliers/1
  ## DELETE /admin/suppliers/1.json
  #def destroy
  #  @supplier = Supplier.find(params[:id])
  #  @supplier.destroy

  #  respond_to do |format|
  #    format.html { redirect_to admin_suppliers_url }
  #    format.json { head :no_content }
  #  end
  #end

  #def supplier_params
  #  params.require(:supplier).permit!
  #end

  private

  def user_set
  end

  def somebody_set
  end

  def supplier_set
    @somebody = @supplier = Supplier.find(params[:id]) if params[:id]
  end

  def set_resource_class
    @resource_class = Supplier
  end


end
