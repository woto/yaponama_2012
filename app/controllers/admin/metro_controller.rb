class Admin::MetroController < Admin::ApplicationController
  # GET /admin/metro
  # GET /admin/metro.json
  def index
    @metro = Metro.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @metro }
    end
  end

  # GET /admin/metro/1
  # GET /admin/metro/1.json
  def show
    @metro = Metro.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @metro }
    end
  end

  # GET /admin/metro/new
  # GET /admin/metro/new.json
  def new
    @metro = Metro.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @metro }
    end
  end

  # GET /admin/metro/1/edit
  def edit
    @metro = Metro.find(params[:id])
  end

  # POST /admin/metro
  # POST /admin/metro.json
  def create
    @metro = Metro.new(params[:metro])

    respond_to do |format|
      if @metro.save
        format.html { redirect_to admin_metro_path(@metro), notice: 'Metro was successfully created.' }
        format.json { render json: @metro, status: :created, location: @metro }
      else
        format.html { render action: "new" }
        format.json { render json: @metro.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /admin/metro/1
  # PUT /admin/metro/1.json
  def update
    @metro = Metro.find(params[:id])

    respond_to do |format|
      if @metro.update_attributes(params[:metro])
        format.html { redirect_to admin_metro_path(@metro), notice: 'Metro was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @metro.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/metro/1
  # DELETE /admin/metro/1.json
  def destroy
    @metro = Metro.find(params[:id])
    @metro.destroy

    respond_to do |format|
      format.html { redirect_to admin_metro_index_url }
      format.json { head :no_content }
    end
  end
end
