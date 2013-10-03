class PassportsController < ProfileablesController

  private

  def set_preferable_columns
    super
    @grid.seriya_visible = '1'
    @grid.nomer_visible = '1'
  end

  def adjust_columns!(columns_hash)
    super
    columns_hash['seriya'] = {
      :type => :string,
    }
    columns_hash['nomer'] = {
      :type => :string,
    }
    columns_hash['passport_vidan'] = {
      :type => :string,
    }
    columns_hash['data_vidachi'] = {
      :type => :date,
    }
    columns_hash['kod_podrazdeleniya'] = {
      :type => :string,
    }
    columns_hash['gender'] = {
      :type => :set,
      :set => Hash[*Rails.configuration.genders.map{|k, v| [v, k]}.flatten],
    }
    columns_hash['data_rozhdeniya'] = {
      :type => :date,
    }
    columns_hash['mesto_rozhdeniya'] = {
      :type => :string,
    }
  end

end
