class PhonesController < ProfileablesController

  private

  def set_preferable_columns
    super
    @grid.value_visible = '1'
  end

  def adjust_columns!(columns_hash)
    super
    columns_hash['value'] = {
      :type => :string,
    }
    columns_hash['mobile'] = {
      :type => :boolean
    }
    columns_hash['confirmed'] = {
      :type => :boolean
    }
    columns_hash['confirmation_datetime'] = {
      :type => :date
    }
  end

end
