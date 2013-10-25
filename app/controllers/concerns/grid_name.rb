#encoding: utf-8

module GridName

  extend ActiveSupport::Concern
  include AbstractGridable

  included do

    def adjust_columns!(columns_hash)

      c1(columns_hash) do

        columns_hash['surname'] = {
          :type => :string,
        }
        columns_hash['name'] = {
          :type => :string,
        }
        columns_hash['patronymic'] = {
          :type => :string,
        }

      end

    end

    def set_preferable_columns
      super
      @grid.visible_surname = '1'
      @grid.visible_name = '1'
      @grid.visible_patronymic = '1'
    end

  end

end
