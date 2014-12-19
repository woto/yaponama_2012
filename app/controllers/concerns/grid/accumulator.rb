# encoding: utf-8
#
module Grid::Accumulator
  extend ActiveSupport::Concern
  include ::AbstractGridable

  included do

    def adjust_columns!(columns_hash)

      c2(columns_hash) do

        columns_hash['checkbox'] = {
          :type => :checkbox,
        }

        columns_hash['voltage'] = {
          :type => :integer,
        }

        columns_hash['battery_capacity'] = {
          :type => :integer,
        }

        columns_hash['cold_cranking_amps'] = {
          :type => :integer,
        }

        columns_hash['length'] = {
          :type => :integer,
        }

        columns_hash['width'] = {
          :type => :integer,
        }

        columns_hash['height'] = {
          :type => :integer,
        }

        columns_hash['base_hold_down'] = {
          :type => :string,
        }

        columns_hash['layout'] = {
          :type => :string,
        }

        columns_hash['terminal_types'] = {
          :type => :string,
        }

        columns_hash['case_size'] = {
          :type => :string,
        }

        columns_hash['weight_filled'] = {
          :type => :float,
        }

        columns_hash['spare_info_id'] = {
          :type => :integer,
        }

        columns_hash['created_at'] = {
          :type => :date,
        }

        columns_hash['updated_at'] = {
          :type => :date,
        }


      end

    end

    def set_preferable_columns
      @grid.visible_checkbox = '1'
      @grid.visible_id = '1'
      @grid.visible_voltage = '1'
      @grid.visible_battery_capacity = '1'
      @grid.visible_cold_cranking_amps = '1'
      @grid.visible_length = '1'
      @grid.visible_width = '1'
      @grid.visible_height = '1'
      @grid.visible_base_hold_down = '1'
      @grid.visible_layout = '1'
      @grid.visible_terminal_types = '1'
      @grid.visible_case_size = '1'
      @grid.visible_weight_filled = '1'
      @grid.visible_spare_info_id = '1'
      @grid.visible_created_at = '1'
      @grid.visible_updated_at = '1'
    end

  end

end

