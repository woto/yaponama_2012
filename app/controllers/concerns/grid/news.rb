module Grid::News
  extend ActiveSupport::Concern
  include ::AbstractGridable

  included do

    def adjust_columns!(columns_hash)

      c2(columns_hash) do

        columns_hash['checkbox'] = {
          :type => :checkbox,
        }

        columns_hash['path'] = {
          :type => :string,
        }

        columns_hash['title'] = {
          :type => :string,
        }

        columns_hash['intro'] = {
          :type => :string,
        }

        columns_hash['body'] = {
          :type => :string,
        }

        columns_hash['attention'] = {
          :type => :boolean
        }

      end

    end

    def set_preferable_columns
      @grid.visible_checkbox = '1'
      @grid.visible_id = '1'
      @grid.visible_path = '1'
      @grid.visible_title = '1'
      @grid.visible_intro = '1'
      @grid.visible_attention = '1'
      @grid.visible_creator_id = '1'
      @grid.visible_updated_at = '1'
    end

  end

end
