class Admin::ProductsController < Admin::ApplicationController
  def index
    @products = Product.where(:status => params[:status])

    respond_to do |format|
      format.html
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


  def destroy
    @product = Product.find(params[:id])
    @product.destroy

    respond_to do |format|
      format.html { redirect_to admin_products_url }
      format.json { head :no_content }
    end
  end


end
