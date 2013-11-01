#encoding: utf-8

module GridBrand
  extend ActiveSupport::Concern
  include AbstractGridable

  included do

    def adjust_columns!(columns_hash)

      c2(columns_hash) do

        columns_hash['name'] = {
          :type => :string,
        }

        columns_hash['image'] = {
          :type => :string,
        }

        columns_hash['rating'] = {
          :type => :number,
        }

        columns_hash['path'] = {
          :type => :string,
        }

        columns_hash['content'] = {
          :type => :string,
        }

        cached_brand(columns_hash)

      end

    end

    def set_preferable_columns
      @grid.visible_id = '1'
      @grid.visible_creator_id = '1'
      @grid.visible_content = '1'
      @grid.visible_path = '1'
      @grid.visible_cached_brand = '1'
      @grid.visible_name = '1'
      @grid.visible_image = '1'
      @grid.visible_rating = '1'
      @grid.visible_created_at = '1'
      @grid.visible_updated_at = '1'
    end

  end

end
