class Admin::CartsController < Admin::ApplicationController
  # GET /admin/carts
  # GET /admin/carts.json
  def index
    @admin_carts = Admin::Cart.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @admin_carts }
    end
  end

  # GET /admin/carts/1
  # GET /admin/carts/1.json
  def show
    @admin_cart = Admin::Cart.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @admin_cart }
    end
  end

  # GET /admin/carts/new
  # GET /admin/carts/new.json
  def new
    @admin_cart = Admin::Cart.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @admin_cart }
    end
  end

  # GET /admin/carts/1/edit
  def edit
    @admin_cart = Admin::Cart.find(params[:id])
  end

  # POST /admin/carts
  # POST /admin/carts.json
  def create
    @admin_cart = Admin::Cart.new(params[:admin_cart])

    respond_to do |format|
      if @admin_cart.save
        format.html { redirect_to @admin_cart, notice: 'Cart was successfully created.' }
        format.json { render json: @admin_cart, status: :created, location: @admin_cart }
      else
        format.html { render action: "new" }
        format.json { render json: @admin_cart.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /admin/carts/1
  # PUT /admin/carts/1.json
  def update
    @admin_cart = Admin::Cart.find(params[:id])

    respond_to do |format|
      if @admin_cart.update_attributes(params[:admin_cart])
        format.html { redirect_to @admin_cart, notice: 'Cart was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @admin_cart.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/carts/1
  # DELETE /admin/carts/1.json
  def destroy
    @admin_cart = Admin::Cart.find(params[:id])
    @admin_cart.destroy

    respond_to do |format|
      format.html { redirect_to admin_carts_url }
      format.json { head :no_content }
    end
  end
end
