class DeliveryZonesController < ApplicationController
  before_action :set_delivery_zone, only: [:show, :edit, :update, :destroy]

  # GET /delivery_zones
  # GET /delivery_zones.json
  def index
    @delivery_zones = DeliveryZone.all
  end

  # GET /delivery_zones/1
  # GET /delivery_zones/1.json
  def show
  end

  # GET /delivery_zones/new
  def new
    @delivery_zone = DeliveryZone.new
  end

  # GET /delivery_zones/1/edit
  def edit
  end

  # POST /delivery_zones
  # POST /delivery_zones.json
  def create
    @delivery_zone = DeliveryZone.new(delivery_zone_params)

    respond_to do |format|
      if @delivery_zone.save
        format.html { redirect_to @delivery_zone, notice: 'Delivery zone was successfully created.' }
        format.json { render action: 'show', status: :created, location: @delivery_zone }
      else
        format.html { render action: 'new' }
        format.json { render json: @delivery_zone.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /delivery_zones/1
  # PATCH/PUT /delivery_zones/1.json
  def update
    respond_to do |format|
      if @delivery_zone.update(delivery_zone_params)
        format.html { redirect_to @delivery_zone, notice: 'Delivery zone was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @delivery_zone.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /delivery_zones/1
  # DELETE /delivery_zones/1.json
  def destroy
    @delivery_zone.destroy
    respond_to do |format|
      format.html { redirect_to delivery_zones_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_delivery_zone
      @delivery_zone = DeliveryZone.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def delivery_zone_params
      params.require(:delivery_zone).permit!
    end
end
