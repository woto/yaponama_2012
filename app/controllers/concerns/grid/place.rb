# encoding: utf-8
#
module Grid::Place

  extend ActiveSupport::Concern
  include ::AbstractGridable

  included do

    def adjust_columns!(columns_hash)

      columns_hash['id'] = {
        :type => :single_integer
      }
      columns_hash['name'] = {
        :type => :string,
      }
      columns_hash['price_url'] = {
        :type => :string,
      }
      columns_hash['image1'] = {
        :type => :string,
      }

      columns_hash['image2'] = {
        :type => :string,
      }

      columns_hash['image3'] = {
        :type => :string,
      }

      columns_hash['image4'] = {
        :type => :string,
      }

      columns_hash['image5'] = {
        :type => :string,
      }
    end

    def set_preferable_columns
      @grid.visible_id = '1'
      @grid.visible_name = '1'
      @grid.visible_price_url = '1'
      @grid.visible_image1 = '1'
    end

  end

end
