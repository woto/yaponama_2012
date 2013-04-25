class ProfileablesController < ApplicationController
  #before_action :set_user
  before_action :set_resource_class
  before_action :set_grid_class
  before_action :set_grid, :only => [:index, :filter]
  include ProfileablesConcern
  include GridConcern

  before_action :set_resource, only: [:show, :edit, :update, :destroy]
  before_action :initialize_on_create, only: [:create]
  before_action :set_user_and_creation_reason, only: [:create, :update]


  # GET /names
  # GET /names.json
  def index

    respond_to do |format|
      format.html
      format.js { render 'shared/filter' }
    end
  end


  def filter

    respond_to do |format|
      format.html
      format.js { render 'shared/filter' }
    end

  end

  def transactions
    if params[:id]
      @resource = @resource_class.find(params[:id])
      @transactions = eval "@resource.#{@resource_class.to_s.underscore}_transactions"
    else
      if @user
        @transactions = eval "@user.#{@resource_class.to_s.underscore}_transactions"
      else
        @transactions = @resource_class.all
      end
    end

    @transactions = @transactions.order(:id => :desc)
  end

  # GET /names/1
  # GET /names/1.json
  def show
  end

  # GET /names/new
  def new
    @resource = @resource_class.new

    if @resource.class == Company
      @resource.build_legal_address
      @resource.build_actual_address

      if @user.postal_addresses.present?
        @resource.legal_address_type = 'old'
        @resource.actual_address_type = 'old'
      else
        @resource.legal_address_type = 'new'
        @resource.actual_address_type = 'old'
      end
    end
  end


  # GET /names/1/edit
  def edit
    @user = @resource.user

    if @resource.class == Company
      @resource.legal_address_type = 'old'
      @resource.actual_address_type = 'old'
    end
  end

  # POST /names
  # POST /names.json
  def create
    respond_to do |format|
      if @resource.save
        format.html { redirect_to url_for(:resource_class => @resource.class.name, :action => :show, :id => @resource), notice: "#{@resource_class} was successfully created." }
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
        format.html { redirect_to url_for(:resource_class => @resource.class.name, :action => :show), notice: "#{@resource_class} was successfully updated." }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @resource.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /names/1
  # DELETE /names/1.json
  def destroy

    @user = @resource.user
    @resource.destroy
    respond_to do |format|
      format.html { redirect_to url_for(:controller => :users, :action => :show), notice: "#{@resource_class} was successfully destroyed" }
      format.json { head :no_content }
    end

  end

  private


  # Use callbacks to share common setup or constraints between actions.
  def set_resource
    @resource = @resource_class.find(params[:id])
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
