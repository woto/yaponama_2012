module Grid::SpareApplicability
  extend ActiveSupport::Concern
  include ::AbstractGridable

  included do

    def adjust_columns!(columns_hash)

      columns_hash['id'] = {
        :type => :integer,
      }

      columns_hash['cached_spare_info'] = {
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

      columns_hash['created_at'] = {
        :type => :date,
      }

      columns_hash['updated_at'] = {
        :type => :date,
      }

    end

    def set_preferable_columns
      @grid.visible_id = '1'
      @grid.visible_cached_spare_info = '1'
      @grid.visible_cached_brand = '1'
      @grid.visible_cached_model = '1'
      @grid.visible_cached_generation = '1'
      @grid.visible_cached_modification = '1'
      @grid.visible_updated_at = '1'
    end

  end

end

