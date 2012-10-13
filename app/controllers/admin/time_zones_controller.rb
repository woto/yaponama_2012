class Admin::TimeZonesController < Admin::ApplicationController
  # GET /time_zones
  # GET /time_zones.json
  def index
    @time_zones = TimeZone.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @time_zones }
    end
  end

  # GET /time_zones/1
  # GET /time_zones/1.json
  def show
    @time_zone = TimeZone.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @time_zone }
    end
  end

  # GET /time_zones/new
  # GET /time_zones/new.json
  def new
    @time_zone = TimeZone.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @time_zone }
    end
  end

  # GET /time_zones/1/edit
  def edit
    @time_zone = TimeZone.find(params[:id])
  end

  # POST /time_zones
  # POST /time_zones.json
  def create
    @time_zone = TimeZone.new(params[:time_zone])

    respond_to do |format|
      if @time_zone.save
        format.html { redirect_to admin_time_zone_path(@time_zone), :notice => 'Time zone was successfully created.' }
        format.json { render :json => @time_zone, :status => :created, :location => @time_zone }
      else
        format.html { render :action => "new" }
        format.json { render :json => @time_zone.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /time_zones/1
  # PUT /time_zones/1.json
  def update
    @time_zone = TimeZone.find(params[:id])

    respond_to do |format|
      if @time_zone.update_attributes(params[:time_zone])
        format.html { redirect_to admin_time_zone(@time_zone), :notice => 'Time zone was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @time_zone.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /time_zones/1
  # DELETE /time_zones/1.json
  def destroy
    @time_zone = TimeZone.find(params[:id])
    @time_zone.destroy

    respond_to do |format|
      format.html { redirect_to admin_time_zones_url }
      format.json { head :no_content }
    end
  end
end
