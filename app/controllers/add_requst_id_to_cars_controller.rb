class AddRequstIdToCarsController < ApplicationController
  # GET /add_requst_id_to_cars
  # GET /add_requst_id_to_cars.json
  def index
    @add_requst_id_to_cars = AddRequstIdToCar.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @add_requst_id_to_cars }
    end
  end

  # GET /add_requst_id_to_cars/1
  # GET /add_requst_id_to_cars/1.json
  def show
    @add_requst_id_to_car = AddRequstIdToCar.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @add_requst_id_to_car }
    end
  end

  # GET /add_requst_id_to_cars/new
  # GET /add_requst_id_to_cars/new.json
  def new
    @add_requst_id_to_car = AddRequstIdToCar.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @add_requst_id_to_car }
    end
  end

  # GET /add_requst_id_to_cars/1/edit
  def edit
    @add_requst_id_to_car = AddRequstIdToCar.find(params[:id])
  end

  # POST /add_requst_id_to_cars
  # POST /add_requst_id_to_cars.json
  def create
    @add_requst_id_to_car = AddRequstIdToCar.new(params[:add_requst_id_to_car])

    respond_to do |format|
      if @add_requst_id_to_car.save
        format.html { redirect_to @add_requst_id_to_car, :notice => 'Add requst id to car was successfully created.' }
        format.json { render :json => @add_requst_id_to_car, :status => :created, :location => @add_requst_id_to_car }
      else
        format.html { render :action => "new" }
        format.json { render :json => @add_requst_id_to_car.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /add_requst_id_to_cars/1
  # PUT /add_requst_id_to_cars/1.json
  def update
    @add_requst_id_to_car = AddRequstIdToCar.find(params[:id])

    respond_to do |format|
      if @add_requst_id_to_car.update_attributes(params[:add_requst_id_to_car])
        format.html { redirect_to @add_requst_id_to_car, :notice => 'Add requst id to car was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @add_requst_id_to_car.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /add_requst_id_to_cars/1
  # DELETE /add_requst_id_to_cars/1.json
  def destroy
    @add_requst_id_to_car = AddRequstIdToCar.find(params[:id])
    @add_requst_id_to_car.destroy

    respond_to do |format|
      format.html { redirect_to add_requst_id_to_cars_url }
      format.json { head :no_content }
    end
  end
end
