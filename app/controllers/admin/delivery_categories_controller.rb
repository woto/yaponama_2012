class Admin::DeliveryCategoriesController < Admin::ApplicationController
  # GET /admin/delivery_categories
  # GET /admin/delivery_categories.json
  def index
    @delivery_categories = DeliveryCategory.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @delivery_categories }
    end
  end

  # GET /admin/delivery_categories/1
  # GET /admin/delivery_categories/1.json
  def show
    @delivery_category = DeliveryCategory.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @delivery_category }
    end
  end

  # GET /admin/delivery_categories/new
  # GET /admin/delivery_categories/new.json
  def new
    @delivery_category = DeliveryCategory.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @delivery_category }
    end
  end

  # GET /admin/delivery_categories/1/edit
  def edit
    @delivery_category = DeliveryCategory.find(params[:id])
  end

  # POST /admin/delivery_categories
  # POST /admin/delivery_categories.json
  def create
    @delivery_category = DeliveryCategory.new(params[:delivery_category])

    respond_to do |format|
      if @delivery_category.save
        format.html { redirect_to admin_delivery_category_path(@delivery_category), notice: 'Delivery category was successfully created.' }
        format.json { render json: @delivery_category, status: :created, location: @delivery_category }
      else
        format.html { render action: "new" }
        format.json { render json: @delivery_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /admin/delivery_categories/1
  # PUT /admin/delivery_categories/1.json
  def update
    @delivery_category = DeliveryCategory.find(params[:id])

    respond_to do |format|
      if @delivery_category.update_attributes(params[:delivery_category])
        format.html { redirect_to admin_delivery_category_path(@delivery_category), notice: 'Delivery category was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @delivery_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/delivery_categories/1
  # DELETE /admin/delivery_categories/1.json
  def destroy
    @delivery_category = DeliveryCategory.find(params[:id])
    @delivery_category.destroy

    respond_to do |format|
      format.html { redirect_to admin_delivery_categories_url }
      format.json { head :no_content }
    end
  end
end
