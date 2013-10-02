class NamesController < ProfileablesController

  private

  def set_preferable_columns
    super
    @grid.surname_visible = '1'
    @grid.name_visible = '1'
    @grid.patronymic_visible = '1'
  end

end
