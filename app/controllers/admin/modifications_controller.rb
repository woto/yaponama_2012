class Admin::ModificationsController < ApplicationController
  include Admin::Admined

  respond_to :json

  def search
    modification_t = Modification.arel_table

    @modifications = Modification.includes(:generation).where(:generations => {:name => params[:generation]}).where(modification_t[:name].matches("#{params[:name]}%")).order(modification_t[:name]).page params[:page]

    respond_with @modifications
  end

  # GET /modifications
  # GET /modifications.json
  def index
    @modifications = Modification.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @modifications }
    end
  end

  # GET /modifications/1
  # GET /modifications/1.json
  def show
    @modification = Modification.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @modification }
    end
  end

  # GET /modifications/new
  # GET /modifications/new.json
  def new
    @modification = Modification.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @modification }
    end
  end

  # GET /modifications/1/edit
  def edit
    @modification = Modification.find(params[:id])
  end

  # POST /modifications
  # POST /modifications.json
  def create
    @modification = Modification.new(modification_params)

    respond_to do |format|
      if @modification.save
        format.html { redirect_to [:admin, @modification], notice: 'Modification was successfully created.' }
        format.json { render json: @modification, status: :created, location: @modification }
      else
        format.html { render action: "new" }
        format.json { render json: @modification.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /modifications/1
  # PATCH/PUT /modifications/1.json
  def update
    @modification = Modification.find(params[:id])

    respond_to do |format|
      if @modification.update_attributes(modification_params)
        format.html { redirect_to [:admin, @modification], notice: 'Modification was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @modification.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /modifications/1
  # DELETE /modifications/1.json
  def destroy
    @modification = Modification.find(params[:id])
    @modification.destroy

    respond_to do |format|
      format.html { redirect_to admin_modifications_url }
      format.json { head :no_content }
    end
  end

  private

    # Use this method to whitelist the permissible parameters. Example:
    # params.require(:person).permit(:name, :age)
    # Also, you can specialize this method with per-user checking of permissible attributes.
    def modification_params
      params.require(:modification).permit(:generation_id, :name)
    end
end
