class Admin::ProductsController < Admin::ApplicationController

  ORDER_STEPS = %w[order delivery postal_address phone name notes]
 
  def index
    products = Product.order("id DESC").page(params[:page])
    @products = products_user_order_tab_scope(products, params[:status])
    respond_to do |format|
      format.html
    end
  end

  def new
    @product = Product.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @product }
    end
  end

  def edit
    @product = Product.find(params[:id])
  end


  def update
    @product = Product.find(params[:id])
    respond_to do |format|
      if @product.update_attributes(params[:product])
        format.html { redirect_to admin_product_path(@product), notice: 'Product info was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @product = Product.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @product }
    end
  end

  def multiple_destroy

    @products = products_user_order_tab_scope( Product.scoped, 'checked' )

    result = {}

    @products.each do |product|
      if product.destroy
        result = { :notice => "Product Successfully deleted" }
      else
        result = { :alert => "Product can't be deleted: #{product.errors[:base].to_s}" }
        break
      end
    end

    respond_to do |format|
      format.html { redirect_to :back, result }
      format.json { head :no_content }
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

  def remember
    session[:products] = {} unless session[:products]
    session[:products] = (session[:products].merge params[:product_ids]).select{|k, v| v == '1'}
    render :nothing => true
  end

end
