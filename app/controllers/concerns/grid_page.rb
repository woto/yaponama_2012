#encoding: utf-8

module GridPage
  extend ActiveSupport::Concern
  include AbstractGridable

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

        columns_hash['keywords'] = {
          :type => :string,
        }

        columns_hash['description'] = {
          :type => :string,
        }

        columns_hash['robots'] = {
          :type => :string,
        }

        columns_hash['content'] = {
          :type => :string,
        }

      end

    end

    def set_preferable_columns
      @grid.visible_checkbox = '1'
      @grid.visible_id = '1'
      @grid.visible_path = '1'
      @grid.visible_title = '1'
      @grid.visible_keywords = '1'
      @grid.visible_description = '1'
      @grid.visible_robots = '1'
      @grid.visible_content = '1'
      @grid.visible_creator_id = '1'
      @grid.visible_updated_at = '1'

    end

  end

end
