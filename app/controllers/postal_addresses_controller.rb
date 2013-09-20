class PostalAddressesController < ProfileablesController

  private

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
