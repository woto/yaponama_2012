class EmailsController < ProfileablesController

  private

  def set_preferable_columns
    super
    @grid.value_visible = '1'
  end

end

