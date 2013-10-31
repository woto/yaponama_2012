class Admin::Deliveries::PlacesController < ApplicationController
  include Admin::Admined
  include GridPlace

  skip_before_filter :set_grid, :only => [:edit, :update, :new, :create, :show, :destroy]
  #before_action :set_deliveries_place, only: [:show, :edit, :update, :destroy]

  #def update
  #  respond_to do |format|
  #    if @resource.update(resource_params)
  #      format.html { redirect_to admin_deliveries_places_path, notice: 'Place was successfully updated.' }
  #      format.json { head :no_content }
  #    else
  #      format.html { render action: 'edit' }
  #      format.json { render json: @resource.errors, status: :unprocessable_entity }
  #    end
  #  end
  #end

  #def destroy
  #  @resource.destroy
  #  respond_to do |format|
  #    format.html { redirect_to admin_deliveries_places_url }
  #    format.json { head :no_content }
  #  end
  #end

  private

    #def set_resource_class
    #  @resource_class = Deliveries::Place
    #end

    def new_resource
      super

      @resource.variants.new

      @resource.zoom = SiteConfig.initial_map_zoom
      @resource.lat = SiteConfig.initial_map_lat
      @resource.lng = SiteConfig.initial_map_lng
      @resource.z_index = 100

      ['active', 'inactive'].each do |style|
        @resource["#{style}_fill_color"] = '#000000'
        @resource["#{style}_fill_opacity"] = '0.5'
        @resource["#{style}_stroke_color"] = '#000000'
        @resource["#{style}_stroke_opacity"] = '0.5'
        @resource["#{style}_stroke_weight"] = '0.5'
      end

    end

    ## Use callbacks to share common setup or constraints between actions.
    #def set_deliveries_places_place
    #  @deliveries_places_place = ::Deliveries::Places::Place.find(params[:id])
    #end

    # Never trust parameters from the scary internet, only allow the white list through.
    #def deliveries_places_place_params
    #  params.require(:deliveries_places_place).permit!
    #  #(:name, :content, :vertices, :postal_address_required, :active_fill_color, :active_fill_opacity, :active_stroke_color, :active_stroke_opacity, :active_stroke_weight, :inactive_fill_color, :inactive_fill_opacity, :inactive_stroke_color, :inactive_stroke_opacity, :inactive_stroke_weight, :lat, :lng, :zoom, :z_index, :display_marker)
    #end

  private

  def set_resource_class
    @resource_class = Deliveries::Place
  end

  def user_set
    @somebody = @user = User.find(params[:user_id]) if params[:user_id]
  end

  def somebody_set
  end

  def supplier_set
    @somebody = @supplier = Supplier.find(params[:supplier_id]) if params[:supplier_id]
  end


  def user_get
  end

  def supplier_get
  end

  def somebody_get
  end

end
