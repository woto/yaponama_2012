class Admin::ModelsController < ApplicationController
  respond_to :json

  def search
    model_t = Admin::Model.arel_table

    @models = Admin::Model.includes(:brand).where(:brands => {:name => params[:brand]}).where(model_t[:name].matches("#{params[:name]}%")).order(model_t[:name]).page params[:page]
    respond_with @models
  end

  # GET /admin/models
  # GET /admin/models.json
  def index
    @admin_models = Admin::Model.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @admin_models }
    end
  end

  # GET /admin/models/1
  # GET /admin/models/1.json
  def show
    @admin_model = Admin::Model.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @admin_model }
    end
  end

  # GET /admin/models/new
  # GET /admin/models/new.json
  def new
    @admin_model = Admin::Model.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @admin_model }
    end
  end

  # GET /admin/models/1/edit
  def edit
    @admin_model = Admin::Model.find(params[:id])
  end

  # POST /admin/models
  # POST /admin/models.json
  def create
    @admin_model = Admin::Model.new(admin_model_params)

    respond_to do |format|
      if @admin_model.save
        format.html { redirect_to @admin_model, notice: 'Model was successfully created.' }
        format.json { render json: @admin_model, status: :created, location: @admin_model }
      else
        format.html { render action: "new" }
        format.json { render json: @admin_model.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/models/1
  # PATCH/PUT /admin/models/1.json
  def update
    @admin_model = Admin::Model.find(params[:id])

    respond_to do |format|
      if @admin_model.update_attributes(admin_model_params)
        format.html { redirect_to @admin_model, notice: 'Model was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @admin_model.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/models/1
  # DELETE /admin/models/1.json
  def destroy
    @admin_model = Admin::Model.find(params[:id])
    @admin_model.destroy

    respond_to do |format|
      format.html { redirect_to admin_models_url }
      format.json { head :no_content }
    end
  end

  private

    # Use this method to whitelist the permissible parameters. Example:
    # params.require(:person).permit(:name, :age)
    # Also, you can specialize this method with per-user checking of permissible attributes.
    def admin_model_params
      params.require(:admin_model).permit(:brand_id, :creator_id, :name)
    end
end
