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
      columns_hash['metro'] = {
        :type => :string,
      }
      (1..5).each do |i|
        columns_hash["image#{i}"] = {
          :type => :string,
        }
      end
    end

    def set_preferable_columns
      @grid.visible_id = '1'
      @grid.visible_name = '1'
      @grid.visible_metro = '1'
      @grid.visible_price_url = '1'
      @grid.visible_image1 = '1'
    end

  end

end
