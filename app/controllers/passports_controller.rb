class PassportsController < ProfileablesController

  private

  def set_preferable_columns
    super
    @grid.seriya_visible = '1'
    @grid.nomer_visible = '1'
  end

end
