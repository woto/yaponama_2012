class Admin::DeliveriesController < Admin::ApplicationController
  # GET /admin/deliveries
  # GET /admin/deliveries.json
  def index
    @deliveries = Delivery.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @deliviries }
    end
  end

  # GET /admin/deliveries/1
  # GET /admin/deliveries/1.json
  def show
    @delivery = Delivery.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @delivery }
    end
  end

  # GET /admin/deliveries/new
  # GET /admin/deliveries/new.json
  def new
    @delivery = Delivery.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @delivery }
    end
  end

  # GET /admin/deliveries/1/edit
  def edit
    @delivery = Delivery.find(params[:id])
  end

  # POST /admin/deliveries
  # POST /admin/deliveries.json
  def create
    @delivery = Delivery.new(params[:delivery])

    respond_to do |format|
      if @delivery.save
        format.html { redirect_to admin_delivery_path(@delivery), notice: 'Delivery was successfully created.' }
        format.json { render json: @delivery, status: :created, location: @delivery }
      else
        format.html { render action: "new" }
        format.json { render json: @delivery.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /admin/deliveries/1
  # PUT /admin/deliveries/1.json
  def update
    @delivery = Delivery.find(params[:id])

    respond_to do |format|
      if @delivery.update_attributes(params[:delivery])
        format.html { redirect_to admin_delivery_path(@delivery), notice: 'Delivery was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @delivery.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/deliveries/1
  # DELETE /admin/deliveries/1.json
  def destroy
    @delivery = Delivery.find(params[:id])
    @delivery.destroy

    respond_to do |format|
      format.html { redirect_to admin_deliveries_url }
      format.json { head :no_content }
    end
  end
end
