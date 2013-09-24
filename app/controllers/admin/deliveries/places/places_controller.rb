class Admin::Deliveries::Places::PlacesController < ApplicationController
  include Admin::Admined
  before_action :set_deliveries_places_place, only: [:show, :edit, :update, :destroy]

  # GET /deliveries/places/places
  # GET /deliveries/places/places.json
  def index
    @deliveries_places_places = ::Deliveries::Places::Place.all
  end

  # GET /deliveries/places/places/1
  # GET /deliveries/places/places/1.json
  def show
  end

  # GET /deliveries/places/places/new
  def new
    @deliveries_places_place = ::Deliveries::Places::Place.new
    @deliveries_places_place.prepare
  end

  # GET /deliveries/places/places/1/edit
  def edit
  end

  # POST /deliveries/places/places
  # POST /deliveries/places/places.json
  def create
    @deliveries_places_place = ::Deliveries::Places::Place.new(deliveries_places_place_params)

    respond_to do |format|
      if @deliveries_places_place.save
        format.html { redirect_to admin_deliveries_places_places_path, notice: 'Place was successfully created.' }
        format.json { render action: 'show', status: :created, location: @deliveries_places_place }
      else
        format.html { render action: 'new' }
        format.json { render json: @deliveries_places_place.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /deliveries/places/places/1
  # PATCH/PUT /deliveries/places/places/1.json
  def update
    respond_to do |format|
      if @deliveries_places_place.update(deliveries_places_place_params)
        format.html { redirect_to admin_deliveries_places_places_path, notice: 'Place was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @deliveries_places_place.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /deliveries/places/places/1
  # DELETE /deliveries/places/places/1.json
  def destroy
    @deliveries_places_place.destroy
    respond_to do |format|
      format.html { redirect_to admin_deliveries_places_places_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_deliveries_places_place
      @deliveries_places_place = ::Deliveries::Places::Place.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def deliveries_places_place_params
      params.require(:deliveries_places_place).permit!
      #(:name, :content, :vertices, :postal_address_required, :active_fill_color, :active_fill_opacity, :active_stroke_color, :active_stroke_opacity, :active_stroke_weight, :inactive_fill_color, :inactive_fill_opacity, :inactive_stroke_color, :inactive_stroke_opacity, :inactive_stroke_weight, :lat, :lng, :zoom, :z_index, :display_marker)
    end
end
