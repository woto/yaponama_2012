module Grid::SpareApplicability

  extend ActiveSupport::Concern
  include ::AbstractGridable

  included do

    def adjust_columns!(columns_hash)

      columns_hash['id'] = {
        :type => :integer,
      }

      columns_hash['spare_info'] = {
        :type => :string,
      }

      columns_hash['brand'] = {
        :type => :string,
      }

      columns_hash['model'] = {
        :type => :string,
      }

      columns_hash['generation'] = {
        :type => :string
      }

      columns_hash['modification'] = {
        :type => :string,
      }

      columns_hash['notes'] = {
        :type => :string,
      }
      columns_hash['notes_invisible'] = {
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
      @grid.visible_spare_info = '1'
      @grid.visible_brand = '1'
      @grid.visible_model = '1'
      @grid.visible_generation = '1'
      @grid.visible_modification = '1'
      @grid.visible_notes = '1'
      @grid.visible_notes_invisible = '1'
      @grid.visible_updated_at = '1'
    end

  end

end

