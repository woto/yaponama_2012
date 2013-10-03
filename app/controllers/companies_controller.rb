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
    super
    @resource.legal_address_type = 'old'
    @resource.actual_address_type = 'old'
  end

  private

  def set_preferable_columns
    super
    @grid.inn_visible = '1'
    @grid.name_visible = '1'
    @grid.ogrn_visible = '1'
    @grid.ownership_visible = '1'
  end

  def adjust_columns!(columns_hash)
    super
    columns_hash['ownership'] = {
      :type => :set,
      :set => Hash[*Rails.configuration.company_ownerships.map{|k, v| [v, k]}.flatten],
    }
    columns_hash['name'] = {
      type: :string
    }
    columns_hash['inn'] = {
      type: :string
    }
    columns_hash['kpp'] = {
      type: :string
    }
    columns_hash['ogrn'] = {
      type: :string
    }
    columns_hash['account'] = {
      type: :string
    }
    columns_hash['bank'] = {
      type: :string
    }
    columns_hash['bik'] = {
      type: :string
    }
    columns_hash['correspondent'] = {
      :type => :string,
    }
    columns_hash['okpo'] = {
      :type => :string,
    }
    columns_hash['okved'] = {
      :type => :string,
    }
    columns_hash['okato'] = {
      :type => :string,
    }
    # TODO когда компаний будет много, будет проблема поиска компании по адресу,
    # но учитывая, что сейчас так же можно искать просто адрес, это частично её решает
    # но при поиске по адресу не происходит отображения компании.
    columns_hash['legal_address_id'] = {
      :type => :belongs_to,
      :belongs_to => PostalAddress
    }
    columns_hash['actual_address_id'] = {
      :type => :belongs_to,
      :belongs_to => PostalAddress
    }
  end

end
