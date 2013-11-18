# encoding: utf-8
#
module GridGeneration
  extend ActiveSupport::Concern
  include AbstractGridable

  included do

    def adjust_columns!(columns_hash)

      c2(columns_hash) do

        columns_hash['name'] = {
          :type => :string,
        }

        cached_model(columns_hash)

        columns_hash['content'] = {
          :type => :string,
        }

      end

    end

    def set_preferable_columns
      @grid.visible_id = '1'
      @grid.visible_creator_id = '1'
      @grid.visible_content = '1'
      @grid.visible_cached_model = '1'
      @grid.visible_name = '1'
      @grid.visible_created_at = '1'
      @grid.visible_updated_at = '1'
    end

  end

end


