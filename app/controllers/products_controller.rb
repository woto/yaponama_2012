class ProductsController < ApplicationController
  include ProductsConcern

  ORDER_STEPS = %w[order delivery postal_address phone name notes]

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
