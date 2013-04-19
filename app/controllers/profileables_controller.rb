class ProfileablesController < ApplicationController
  before_action :set_resource_class
  before_action :set_grid_class
  before_action :set_grid, :only => [:index, :filter]
  include GridConcern

  before_action :set_resource, only: [:show, :edit, :update, :destroy]
  before_action :initialize_on_create, only: [:create]
  before_action :set_user_and_creation_reason, only: [:create, :update]

  def set_resource_class
    @resource_class = params[:resource_class].singularize.constantize
  end

  # GET /names
  # GET /names.json
  def index

    case @resource_class.to_s
    when 'Name'
      @grid.name_visible = '1'
    when 'Phone'
      @grid.phone_visible = '1'
    when 'EmailAddress'
      @grid.email_address_visible = '1'
    when 'PostalAddress'
      @grid.city_visible = '1'
      @grid.house_visible = '1'
      @grid.postcode_visible = '1'
      @grid.region_visible = '1'
      @grid.room_visible = '1'
      @grid.street_visible = '1'
    when 'Car'
      @grid.brand_visible = '1'
      @grid.frame_visible = '1'
      @grid.god_visible = '1'
      @grid.model_visible = '1'
      @grid.vin_visible = '1'
    when 'Company'
      @grid.inn_visible = '1'
      @grid.name_visible = '1'
      @grid.ogrn_visible = '1'
      @grid.ownership_visible = '1'
    end

    @grid.notes_visible = '1'

    respond_to do |format|
      format.html
      format.js { render :filter }
    end
  end


  def filter

    respond_to do |format|
      format.html { render :index }
      format.js
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

  def set_grid_class
    @grid_class = Class.new(AbstractGrid)

    columns_hash = {}

    # Не очень красиво, но рабочее, пересекающихся полей разного типа не планируется
    @resource_class.column_names.each do |column_name|
      case column_name
      when 'phone_type'
        columns_hash[column_name] = {
          :type => :set,
          :set => Hash[*Rails.configuration.phone_types.map{|k, v| [v, k]}.flatten],
        }
      when *['created_at', 'updated_at', 'user_confirmation_datetime', 'manager_confirmation_datetime']
        columns_hash[column_name] = {
          :type => :date
        }
      when *['confirmed_by_user', 'confirmed_by_manager']
        columns_hash[column_name] = {
          :type => :boolean,
        }
      when 'ownership'
        columns_hash[column_name] = {
          :type => :set,
          :set => Hash[*Rails.configuration.company_ownerships.map{|k, v| [v, k]}.flatten],
        }
      when 'id'
        columns_hash[column_name] = {
          :type => :belongs_to,
          :belongs_to => @resource_class,
        }
      when 'creation_reason'
        columns_hash[column_name] = {
          :type => :set,
          :set => eval("Hash[*Rails.configuration.user_#{@resource_class.name.underscore}_creation_reason.map{|k, v| [v, k]}.flatten]"),
        }
      when 'notes_invisible'
        if ["admin", "manager"].include?(current_user.role)
          columns_hash[column_name] = {
            :type => :string,
          }
        end
      else
        columns_hash[column_name] = {
          :type => :string,
        }
      end
    end

    @grid_class.const_set("COLUMNS", columns_hash)
  end

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
