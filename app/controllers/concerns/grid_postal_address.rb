#encoding: utf-8

module GridPostalAddress

  extend ActiveSupport::Concern
  include AbstractGridable

  included do

    def adjust_columns!(columns_hash)

      c1(columns_hash) do

        columns_hash['postcode'] = {
          type: :string
        }
        columns_hash['region'] = {
          type: :string
        }
        columns_hash['city'] = {
          type: :string
        }
        columns_hash['street'] = {
          type: :string
        }
        columns_hash['house'] = {
          type: :string
        }
        columns_hash['stand_alone_house'] = {
          type: :boolean
        }
        columns_hash['room'] = {
          type: :string
        }

      end

    end

    def set_preferable_columns
      super
      @grid.visible_city = '1'
      @grid.visible_house = '1'
      @grid.visible_postcode = '1'
      @grid.visible_region = '1'
      @grid.visible_room = '1'
      @grid.visible_street = '1'
    end

  end

end
