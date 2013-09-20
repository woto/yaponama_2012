class NamesController < ProfileablesController

  private

  def set_preferable_columns
    super
    @grid.name_visible = '1'
  end

end
