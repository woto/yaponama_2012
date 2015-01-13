# encoding: utf-8
#
module Grid::SpareInfo
  extend ActiveSupport::Concern
  include ::AbstractGridable

  included do

    def adjust_columns!(columns_hash)

      id(columns_hash)

      columns_hash['catalog_number'] = {
        :type => :string,
      }

      columns_hash['cached_brand'] = {
        :type => :string,
      }

      columns_hash['cached_spare_catalog'] = {
        :type => :string,
      }

      (1..8).each do |i|
        columns_hash["image#{i}"] = {
          :type => :string,
        }
      end

      (1..8).each do |i|
        columns_hash["file#{i}"] = {
          :type => :string,
        }
      end

      columns_hash['content'] = {
        :type => :string,
      }

      columns_hash['shows'] = {
        :type => :number,
      }

      columns_hash['notes'] = {
        :type => :string,
      }
      columns_hash['notes_invisible'] = {
        :type => :string,
      }

      created_at(columns_hash)

      updated_at(columns_hash)

    end

    def set_preferable_columns
      @grid.visible_id = '1'
      @grid.visible_catalog_number = '1'
      @grid.visible_cached_brand = '1'
      @grid.visible_cached_spare_catalog = '1'
      @grid.visible_image1 = '1'
      @grid.visible_content = '1'
      @grid.visible_shows = '1'
      @grid.visible_notes = '1'
      @grid.visible_notes_invisible = '1'
      @grid.visible_created_at = '1'
      @grid.visible_updated_at = '1'
    end

  end

end
