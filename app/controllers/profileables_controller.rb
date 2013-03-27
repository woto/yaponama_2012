class ProfileablesController < ApplicationController
  before_action :set_resource_class
  before_action :set_resource, only: [:show, :edit, :update, :destroy, :toggle]
  before_action :initialize_on_create, only: [:create]
  before_action :set_user_and_creation_reason, only: [:create, :update]
  before_action :find_approriate_resources, only: [:index]
  before_action :set_user, only: [:show, :update, :create]

  def set_resource_class
    @resource_class = params[:resource_class].singularize.constantize
  end

  # GET /names
  # GET /names.json
  def index
  end

  # GET /names/1
  # GET /names/1.json
  def show
  end

  # GET /names/new
  def new
    @resource = @resource_class.new
    @user = User.find(current_user)
  end

  # GET /names/1/edit
  def edit
    @user = @resource.user
  end

  # POST /names
  # POST /names.json
  def create

    respond_to do |format|
      if @resource.save
        format.html { redirect_to polymorphic_path(complex_namespace_helper + [@resource]), notice: "#{@resource_class} was successfully created." }
        format.json { render action: 'show', status: :created, location: @resource }
      else
        format.html { render action: 'new' }
        format.json { render json: @resource.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /names/1
  # PATCH/PUT /names/1.json
  def update
    respond_to do |format|
      if @resource.update(resource_params)
        format.html { redirect_to polymorphic_path(complex_namespace_helper + [@resource]), notice: "#{@resource_class} was successfully updated." }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @resource.errors, status: :unprocessable_entity }
      end
    end
  end

  def toggle
    @user = @resource.user

    if @resource.removed == true
      @resource.removed = false
    else
      @resource.removed = true
    end

    @resource.save!

    respond_to do |format|
      format.html { redirect_to polymorphic_path(complex_namespace_helper) }
      format.json { head :no_content }
    end
  end

  # DELETE /names/1
  # DELETE /names/1.json
  def destroy

    @user = @resource.user
    @resource.destroy
    respond_to do |format|
      format.html { redirect_to polymorphic_path(complex_namespace_helper) }
      format.json { head :no_content }
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_resource
      @resource = @resource_class.find(params[:id])
    end

    def find_approriate_resources
      @resources = @resource_class.where(:user_id => current_user)
    end

    def initialize_on_create
      @resource = @resource_class.new(resource_params)
    end

    def set_user_and_creation_reason

      @resource.user = current_user

      if @resource.creation_reason.blank?
        @resource.creation_reason = 'self'
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def resource_params
      # TODO DANGER!
      params.require(@resource_class.name.underscore.to_sym).permit!
    end

end
