class CompaniesController < ProfileablesController
  include GridCompany

  # GET /companies/new
  def new
    super

    @resource.build_legal_address
    @resource.build_actual_address

    if @somebody.postal_addresses.present?
      @resource.legal_address_type = 'old'
      @resource.actual_address_type = 'old'
    else
      @resource.legal_address_type = 'new'
      @resource.actual_address_type = 'old'
    end

  end

  # GET /companies/1/edit
  def edit
    super
    @resource.legal_address_type = 'old'
    @resource.actual_address_type = 'old'
  end

  private

  def set_resource_class
    @resource_class = Company
  end

end
