class Admin::GenerationsController < ApplicationController
  include Admined

  respond_to :json

  def search
    generation_t = Generation.arel_table

    @generations = Generation.includes(:model).where(:models => {:name => params[:model]}).where(generation_t[:name].matches("#{params[:name]}%")).order(generation_t[:name]).page params[:page]

    respond_with @generations
  end

  # GET /generations
  # GET /generations.json
  def index
    @generations = Generation.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @generations }
    end
  end

  # GET /generations/1
  # GET /generations/1.json
  def show
    @generation = Generation.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @generation }
    end
  end

  # GET /generations/new
  # GET /generations/new.json
  def new
    @generation = Generation.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @generation }
    end
  end

  # GET /generations/1/edit
  def edit
    @generation = Generation.find(params[:id])
  end

  # POST /generations
  # POST /generations.json
  def create
    @generation = Generation.new(generation_params)

    respond_to do |format|
      if @generation.save
        format.html { redirect_to [:admin, @generation], notice: 'Generation was successfully created.' }
        format.json { render json: @generation, status: :created, location: @generation }
      else
        format.html { render action: "new" }
        format.json { render json: @generation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /generations/1
  # PATCH/PUT /generations/1.json
  def update
    @generation = Generation.find(params[:id])

    respond_to do |format|
      if @generation.update_attributes(generation_params)
        format.html { redirect_to [:admin, @generation], notice: 'Generation was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @generation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /generations/1
  # DELETE /generations/1.json
  def destroy
    @generation = Generation.find(params[:id])
    @generation.destroy

    respond_to do |format|
      format.html { redirect_to admin_generations_url }
      format.json { head :no_content }
    end
  end

  private

    # Use this method to whitelist the permissible parameters. Example:
    # params.require(:person).permit(:name, :age)
    # Also, you can specialize this method with per-user checking of permissible attributes.
    def generation_params
      params.require(:generation).permit(:model_id, :name)
    end
end
