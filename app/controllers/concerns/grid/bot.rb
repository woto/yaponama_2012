module Grid::Bot
  extend ActiveSupport::Concern
  include ::AbstractGridable

  included do

    def adjust_columns!(columns_hash)

      c2(columns_hash) do

        columns_hash['title'] = {
          :type => :string,
        }

        columns_hash['user_agent'] = {
          :type => :string,
        }

        columns_hash['inet'] = {
          :type => :ip_address,
        }

        columns_hash['block'] = {
          :type => :string,
        }

        columns_hash['comment'] = {
          :type => :string,
        }

      end

    end

    def set_preferable_columns
      @grid.visible_id = '1'
      @grid.visible_title = '1'
      @grid.visible_user_agent = '1'
      @grid.visible_inet = '1'
      @grid.visible_block = '1'
      @grid.visible_comment = '1'
      @grid.visible_created_at = '1'
      @grid.visible_updated_at = '1'
    end

  end

end

