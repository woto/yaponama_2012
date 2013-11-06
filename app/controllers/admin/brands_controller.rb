class Admin::BrandsController < BrandsController
  include Admin::Admined
  include GridBrand

  skip_before_filter :set_grid, :only => [:new, :create, :edit, :update, :show, :destroy, :search]
  skip_before_filter :only_authenticated, :only => :search

  respond_to :json

  def search
    brand_t = Brand.arel_table

    @resources = Brand

    if params[:name].present?
      @resources = Brand.where(brand_t[:name].matches("#{params[:name]}%"))
    end

    @resources = @resources.order(:name).page params[:page]

    respond_with @resources
  end


  private

  def set_user_and_creation_reason
    super
    @resource.phantom = false
  end

  def user_set
    @somebody = @user = User.find(params[:user_id]) if params[:user_id]
  end

  def somebody_set
  end

  def supplier_set
    @somebody = @supplier = Supplier.find(params[:supplier_id]) if params[:supplier_id]
  end

  def get_user_from_resource
  end

  def user_get
  end

  def supplier_get
  end

  def somebody_get
  end

  def find_resource
    @resource = Brand.find(params[:id])
  end

end
