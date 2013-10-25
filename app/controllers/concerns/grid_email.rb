#encoding: utf-8

module GridEmail

  extend ActiveSupport::Concern
  include AbstractGridable

  included do

    def adjust_columns!(columns_hash)

      c1(columns_hash) do

        columns_hash['value'] = {
          :type => :string,
        }
        columns_hash['confirmed'] = {
          :type => :boolean
        }
        columns_hash['confirmation_datetime'] = {
          :type => :date
        }

      end

    end

    def set_preferable_columns
      super
      @grid.visible_value = '1'
    end

  end

end
