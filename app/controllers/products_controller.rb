class ProductsController < ApplicationController
  include ProductsConcern
  include GridConcern

  ORDER_STEPS = %w[order delivery postal_address phone name notes]

  before_action :only => [:index, :filter, :multiple_destroy] do
    class_eval do
      include ProductsConcern
    end
    set_resource_class
    set_grid_class
    set_grid
  end

  def transactions

    transactions = ProductTransaction

    # TODO убрать дублирование @user.id... @supplier.id...
    if @user
      transactions = ProductTransaction.where("user_id_before = ? OR user_id_after = ?", @user.id, @user.id)
      klass = @user.class
    end

    if @supplier
      transactions = ProductTransaction.where("supplier_id_before = ? OR supplier_id_after = ?", @supplier.id, @supplier.id )
      klass = @supplier.class
    end

    if params[:id]
      transactions = ProductTransaction.where(:product_id => params[:id])
    end

    @transactions = transactions.order("id DESC").page(params[:page])

    respond_to do |format|
      format.html { render 'profileables/transactions' }
      format.json { render json: @product_transactions }
    end
  end

  def index

    respond_to do |format|
      format.html
      format.js { render 'shared/filter' }
    end

  end

  def multiple_destroy

    begin

      @items = products_user_order_tab_scope( @items, 'checked' )

      products_any_checked_validation
      products_all_statuses_validation ['cancel']

      result = {}

      @items.each do |item|
        if item.destroy
          result = { :notice => "Product Successfully deleted" }
        else
          result = { :alert => "Product can't be deleted: #{item.errors[:base].to_s}" }
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

  #def destroy
  #  @product = Product.find(params[:id])
  #  if @product.destroy
  #    result = { :notice => "Product Successfully deleted" }
  #  else
  #    result = { :alert => "Product can't be deleted: #{@product.errors[:base].to_s}" }
  #  end
  #  respond_to do |format|
  #    format.html { redirect_to :back, result }
  #    format.json { head :no_content }
  #  end
  #end

  def filter

    respond_to do |format|
      format.html
      format.js { render 'shared/filter' }
    end

  end

  def url_options
    params.delete :grid
    params.delete :utf8
    params.delete :columns
    params.delete :items
    params.delete :filters
    params.delete :per_page
    super
  end

end
