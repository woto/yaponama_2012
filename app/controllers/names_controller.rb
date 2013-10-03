class NamesController < ProfileablesController

  private

  def set_preferable_columns
    super
    @grid.surname_visible = '1'
    @grid.name_visible = '1'
    @grid.patronymic_visible = '1'
  end

  def adjust_columns!(columns_hash)
    super
    columns_hash['surname'] = {
      :type => :string,
    }
    columns_hash['name'] = {
      :type => :string,
    }
    columns_hash['patronymic'] = {
      :type => :string,
    }
  end

end
