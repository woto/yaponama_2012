# encoding: utf-8
#
module GridSpareCatalog
  extend ActiveSupport::Concern
  include AbstractGridable

  included do

    def adjust_columns!(columns_hash)

      columns_hash['id'] = {
        :type => :integer,
      }

      columns_hash['checkbox'] = {
        :type => :checkbox,
      }

      columns_hash['name'] = {
        :type => :string,
      }

      columns_hash['content'] = {
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
      @grid.visible_checkbox = '1'
      @grid.visible_id = '1'
      @grid.visible_name = '1'
      @grid.visible_content = '1'
      @grid.visible_updated_at = '1'

    end

  end

end
