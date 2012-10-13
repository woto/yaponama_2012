class PingsController < ApplicationController
  # GET /pings
  # GET /pings.json
  def index
    @pings = Ping.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @pings }
    end
  end

  # GET /pings/1
  # GET /pings/1.json
  def show
    @ping = Ping.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @ping }
    end
  end

  # GET /pings/new
  # GET /pings/new.json
  def new
    @ping = Ping.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @ping }
    end
  end

  # GET /pings/1/edit
  def edit
    @ping = Ping.find(params[:id])
  end

  # POST /pings
  # POST /pings.json
  def create
    @ping = Ping.new(params[:ping])

    respond_to do |format|
      if @ping.save
        format.html { redirect_to @ping, :notice => 'Ping was successfully created.' }
        format.json { render :json => @ping, :status => :created, :location => @ping }
      else
        format.html { render :action => "new" }
        format.json { render :json => @ping.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /pings/1
  # PUT /pings/1.json
  def update
    @ping = Ping.find(params[:id])

    respond_to do |format|
      if @ping.update_attributes(params[:ping])
        format.html { redirect_to @ping, :notice => 'Ping was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @ping.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /pings/1
  # DELETE /pings/1.json
  def destroy
    @ping = Ping.find(params[:id])
    @ping.destroy

    respond_to do |format|
      format.html { redirect_to pings_url }
      format.json { head :no_content }
    end
  end
end
