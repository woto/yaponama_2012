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

  def adjust_columns!(columns_hash)
    super
      columns_hash['god'] = {
        :type => :number,
      }
      columns_hash['period'] = {
        :type => :string,
      }
      columns_hash['brand'] = {
        :type => :string,
      }
      columns_hash['model'] = {
        :type => :string,
      }
      columns_hash['generation'] = {
        :type => :string,
      }
      columns_hash['modification'] = {
        :type => :string,
      }
      columns_hash['dvigatel'] = {
        :type => :string,
      }
      columns_hash['tip'] = {
        :type => :string,
      }
      columns_hash['moschnost'] = {
        :type => :string,
      }
      columns_hash['privod'] = {
        :type => :string,
      }
      columns_hash['tip_kuzova'] = {
        :type => :string,
      }
      columns_hash['kpp'] = {
        :type => :string,
      }
      columns_hash['kod_kuzova'] = {
        :type => :string,
      }
      columns_hash['kod_dvigatelya'] = {
        :type => :string,
      }
      columns_hash['rinok'] = {
        :type => :string,
      }
      columns_hash['vin'] = {
        :type => :string,
      }
      columns_hash['frame'] = {
        :type => :string,
      }
      columns_hash['komplektaciya'] = {
        :type => :string,
      }
      columns_hash['dverey'] = {
        :type => :single_integer,
      }
      columns_hash['rul'] = {
        :type => :string,
      }
      columns_hash['car_number'] = {
        :type => :string,
      }
  end

end

