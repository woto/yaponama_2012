class CarsController < ProfileablesController

  private

  def set_preferable_columns
    super
    @grid.brand_visible = '1'
    @grid.frame_visible = '1'
    @grid.god_visible = '1'
    @grid.model_visible = '1'
    @grid.vin_visible = '1'
  end

end

