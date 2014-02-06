# encoding: utf-8
#
module GridPlace

  extend ActiveSupport::Concern
  include AbstractGridable

  included do

    def adjust_columns!(columns_hash)

      columns_hash['id'] = {
        :type => :single_integer
      }
      columns_hash['name'] = {
        :type => :string,
      }

    end

    def set_preferable_columns
      @grid.visible_id = '1'
      @grid.visible_name = '1'
    end

  end

end
