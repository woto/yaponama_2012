# encoding: utf-8
#
module GridSpareInfo
  extend ActiveSupport::Concern
  include AbstractGridable

  included do

    def adjust_columns!(columns_hash)

      id(columns_hash)

      columns_hash['catalog_number'] = {
        :type => :string,
      }

      columns_hash['content'] = {
        :type => :string,
      }

      cached_brand(columns_hash)

      created_at(columns_hash)

      updated_at(columns_hash)

    end

    def set_preferable_columns
      @grid.visible_id = '1'
      @grid.visible_catalog_number = '1'
      @grid.visible_content = '1'
      @grid.visible_cached_brand = '1'
      @grid.visible_created_at = '1'
      @grid.visible_updated_at = '1'
    end

  end

end
