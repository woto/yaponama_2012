module Resource
  extend ActiveSupport::Concern
  included do
  before_action :set_resource_class
  before_action :find_resource, except: [:new, :create, :index]
  before_action :find_resources, only: [:index]
  before_action :new_resource, only: [:new]
  before_action :edit_resource, only: [:edit]
  before_action :create_resource, only: [:create]
  before_action :update_resource, only: [:update]
  # Потом вынести в concern transactionable?
  skip_before_action :find_resource, only: [:transactions]

  def set_resource_class
  end


  def find_resources
    @resources = @resource_class.page(params[:page]).per(params[:per]) if @resource_class
  end

  def find_resource
    @resource = @resource_class.finder(params[:id])
  end

  def new_resource
    @resource = @resource_class.new resource_params
  end

  def edit_resource
  end

  def create_resource
    @resource = @resource_class.new(resource_params)
  end

  def update_resource
    @resource.assign_attributes(resource_params)
  end

  def resource_params
    # TODO DANGER!
    params.fetch(@resource_class.name.underscore.gsub('/', '_').to_sym, {}).permit!
  end

  end
end
