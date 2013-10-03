class PostalAddressesController < ProfileablesController

  private

  def adjust_columns!(columns_hash)
    super
    columns_hash['postcode'] = {
      type: :string
    }
    columns_hash['region'] = {
      type: :string
    }
    columns_hash['city'] = {
      type: :string
    }
    columns_hash['street'] = {
      type: :string
    }
    columns_hash['house'] = {
      type: :string
    }
    columns_hash['stand_alone_house'] = {
      type: :boolean
    }
    columns_hash['room'] = {
      type: :string
    }
  end

  def set_preferable_columns
    super
    @grid.city_visible = '1'
    @grid.house_visible = '1'
    @grid.postcode_visible = '1'
    @grid.region_visible = '1'
    @grid.room_visible = '1'
    @grid.street_visible = '1'
  end

end
