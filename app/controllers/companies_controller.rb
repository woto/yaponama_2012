class CompaniesController < ProfileablesController

  # GET /companies/new
  def new
    super

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

  # GET /companies/1/edit
  def edit
    @resource.legal_address_type = 'old'
    @resource.actual_address_type = 'old'
  end

end
