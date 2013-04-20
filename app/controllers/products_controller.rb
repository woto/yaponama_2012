class ProductsController < ApplicationController
  before_action :set_user
  include ProductsConcern
  include GridConcern

  ORDER_STEPS = %w[order delivery postal_address phone name notes]

  before_action :set_grid, :only => [:index, :filter, :multiple_destroy]

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

  def set_user
    @user = current_user
  end

  private

  def set_resource_class
    @resource_class = Product
  end

  def set_preferable_columns

    @grid.id_visible = '1'
    @grid.short_name_visible = '1'
    @grid.sell_cost_visible = '1'
    @grid.quantity_ordered_visible = '1'
    @grid.manufacturer_visible = '1'
    @grid.catalog_number_visible = '1'
    @grid.updated_at_visible = '1'


    unless @user
      @grid.user_id_visible = "1"
    end

    if ['inorder', 'ordered', 'pre_supplier', 'post_supplier', 'stock', 'complete'].include?(params[:status]) && params[:order_id].blank?
      @grid.order_id_visible = '1'
    end

    if ['post_supplier'].include? params[:status]
      @grid.supplier_id_visible = '1'
    end

    if params[:status].blank? || ['all'].include?(params[:status])
      @grid.status_visible = '1'
    end

  end

  def additional_conditions

    if @user
      @items = @items.where(:user_id => @user.id)
    end

    if params[:status] != 'all' && params[:status].present?
      @items = @items.where(:status => params[:status]) 
    end

    if params[:order_id]
      @items = @items.where(:order_id => params[:order_id])
    end

  end

end
