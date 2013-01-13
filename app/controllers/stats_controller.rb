class StatsController < Admin::ApplicationController
  # GET /stats
  # GET /stats.json
  def index
    @stats = Stat.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @stats }
    end
  end

  def iframe
    $redis = Redis.new(:host => 'localhost', :port => 6379)
    debugger
    render :text => $redis.get('page')
  end

  # GET /stats/1
  # GET /stats/1.json
  def show
    @stat = Stat.find(params[:id])

    respond_to do |format|
      format.html { render "show" }
      format.json { render json: @stat }
    end
  end

  # GET /stats/new
  # GET /stats/new.json
  def new
    @stat = Stat.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @stat }
    end
  end

  # GET /stats/1/edit
  def edit
    @stat = Stat.find(params[:id])
  end

  # POST /stats
  # POST /stats.json
  def create
    @stat = Stat.new(params[:stat])

    @stat.user = current_user

    # brs
    # brs заполняется на стороне клиента и соответственно #TODO только эти поля должны быть attr_accessible

    # geo
    geo = Ipgeobase.lookup(request.remote_ip)
    @stat.geo_city = geo.city.encode if geo.city.present?
    @stat.geo_country = geo.country.encode if geo.country.present?
    @stat.geo_region = geo.region.encode if geo.region.present?
    @stat.geo_district = geo.district.encode if geo.district.present?
    @stat.geo_lat = geo.lat if geo.lat.present?
    @stat.geo_lng = geo.lng if geo.lng.present?

    # req
    @stat.req_remote_addr	      = request.remote_addr	
    @stat.req_ip	              = request.ip	
    @stat.req_remote_ip	        = request.remote_ip	
    @stat.req_user_agent	      = request.user_agent	
    @stat.req_referrer	        = request.referrer	
    @stat.req_referer	          = request.referer	
    @stat.req_accepts	          = request.accepts	
    @stat.req_accept	          = request.accept	
    @stat.req_path	            = request.path	
    @stat.req_base_url	        = request.base_url	
    @stat.req_scheme	          = request.scheme	
    @stat.req_request_method	  = request.request_method	
    @stat.req_original_fullpath	= request.original_fullpath	
    @stat.req_fullpath	        = request.fullpath	
    @stat.req_original_url	    = request.original_url	
    @stat.req_url	              = request.url	

    respond_to do |format|
      if @stat.save
        format.html { redirect_to @stat, notice: 'Stat was successfully created.' }
        format.json { render json: @stat, status: :created, location: @stat }
      else
        format.html { render action: "new" }
        format.json { render json: @stat.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /stats/1
  # PUT /stats/1.json
  def update
    @stat = Stat.find(params[:id])

    respond_to do |format|
      if @stat.update_attributes(params[:stat])
        format.html { redirect_to @stat, notice: 'Stat was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @stat.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stats/1
  # DELETE /stats/1.json
  def destroy
    @stat = Stat.find(params[:id])
    @stat.destroy

    respond_to do |format|
      format.html { redirect_to stats_url }
      format.json { head :no_content }
    end
  end
end
