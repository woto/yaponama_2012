# encoding: utf-8
#
module Grid::Option
  extend ActiveSupport::Concern
  include ::AbstractGridable

  included do

    def adjust_columns!(columns_hash)
      columns_hash['id'] = {
        :type => :single_integer
      }
    end

    def set_preferable_columns
      @grid.visible_id = '1'
    end

  end

end

