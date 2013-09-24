class Admin::ModelsController < ApplicationController
  include Admin::Admined

  respond_to :json

  def search
    model_t = Model.arel_table

    @models = Model.includes(:brand).where(:brands => {:name => params[:brand]}).where(model_t[:name].matches("#{params[:name]}%")).order(model_t[:name]).page params[:page]
    respond_with @models
  end

  # GET /admin/models
  # GET /admin/models.json
  def index
    @models = Model.order(:name)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @models }
    end
  end

  # GET /admin/models/1
  # GET /admin/models/1.json
  def show
    @model = Model.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @model }
    end
  end

  # GET /admin/models/new
  # GET /admin/models/new.json
  def new
    @model = Model.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @model }
    end
  end

  # GET /admin/models/1/edit
  def edit
    @model = Model.find(params[:id])
  end

  # POST /admin/models
  # POST /admin/models.json
  def create
    @model = Model.new(model_params)

    respond_to do |format|
      if @model.save
        format.html { redirect_to [:admin, @model], notice: 'Model was successfully created.' }
        format.json { render json: @model, status: :created, location: @model }
      else
        format.html { render action: "new" }
        format.json { render json: @model.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/models/1
  # PATCH/PUT /admin/models/1.json
  def update
    @model = Model.find(params[:id])

    respond_to do |format|
      if @model.update_attributes(model_params)
        format.html { redirect_to [:admin, @model], notice: 'Model was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @model.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/models/1
  # DELETE /admin/models/1.json
  def destroy
    @model = Model.find(params[:id])
    @model.destroy

    respond_to do |format|
      format.html { redirect_to admin_models_url }
      format.json { head :no_content }
    end
  end

  private

    # Use this method to whitelist the permissible parameters. Example:
    # params.require(:person).permit(:name, :age)
    # Also, you can specialize this method with per-user checking of permissible attributes.
    def model_params
      params.require(:model).permit(:brand_id, :creator_id, :name)
    end
end
