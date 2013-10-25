#encoding: utf-8

module GridModification
  extend ActiveSupport::Concern
  include AbstractGridable

  included do

    def adjust_columns!(columns_hash)

      c2(columns_hash) do
        cached_generation(columns_hash)
        name(columns_hash)
      end

    end

    def set_preferable_columns
      @grid.visible_id = '1'
      @grid.visible_cached_generation = '1'
      @grid.visible_name = '1'
      @grid.visible_created_at = '1'
      @grid.visible_updated_at = '1'
    end

  end

end
