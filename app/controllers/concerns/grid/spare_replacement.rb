module Grid::SpareReplacement
  extend ActiveSupport::Concern
  include ::AbstractGridable

  included do
    def adjust_columns!(columns_hash)
      columns_hash['id'] = {
        :type => :integer,
      }
      columns_hash['from_cached_spare_info'] = {
        :type => :string,
      }
      columns_hash['to_cached_spare_info'] = {
        :type => :string,
      }
      columns_hash['wrong'] = {
        :type => :boolean,
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
      @grid.visible_from_cached_spare_info = '1'
      @grid.visible_to_cached_spare_info = '1'
      @grid.visible_wrong = '1'
      @grid.visible_notes = '1'
      @grid.visible_notes_invisible = '1'
      @grid.visible_updated_at = '1'
    end
  end
end
