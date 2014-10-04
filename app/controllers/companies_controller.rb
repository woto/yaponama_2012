# encoding: utf-8
#
class CompaniesController < ProfileablesController
  include Grid::Company

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

    @resource.old_legal_address = @resource.legal_address
    @resource.old_legal_address_id = @resource.legal_address_id

    @resource.old_actual_address = @resource.actual_address
    @resource.old_actual_address_id = @resource.actual_address_id
  end

  private

  def set_resource_class
    @resource_class = Company
    @postal_address_type = 'companies'
  end

end
