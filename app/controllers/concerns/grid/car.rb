# encoding: utf-8
#
module Grid::Car

  extend ActiveSupport::Concern
  include ::AbstractGridable

  included do

    def adjust_columns!(columns_hash)

      c1(columns_hash) do

        columns_hash['god'] = {
          :type => :number,
        }

        columns_hash['period'] = {
          :type => :string,
        }

        columns_hash['cached_brand'] = {
          :type => :string,
        }

        columns_hash['cached_model'] = {
          :type => :string,
        }

        columns_hash['cached_generation'] = {
          :type => :string
        }

        columns_hash['cached_modification'] = {
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

        columns_hash['vin_or_frame'] = {
          :type => :set,
          :set => Hash[*Rails.configuration.vin_or_frame.map{|k, v| [v, k]}.flatten],
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

    def set_preferable_columns
      super
      @grid.visible_cached_brand = '1'
      @grid.visible_cached_model = '1'
      @grid.visible_frame = '1'
      @grid.visible_god = '1'
      @grid.visible_vin = '1'
    end

  end

end

