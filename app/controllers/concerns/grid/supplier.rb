# encoding: utf-8
#
module Grid::Supplier

  extend ActiveSupport::Concern
  include ::AbstractGridable

  included do

    def adjust_columns!(columns_hash)

      id(columns_hash)

      columns_hash['cached_profile'] = {
        :type => :string
      }

      columns_hash['cached_credit'] = {
        :type => :number
      }

      columns_hash['cached_debit'] = {
        :type => :number
      }

      created_at(columns_hash)
      updated_at(columns_hash)
      phantom(columns_hash)

    end

    def set_preferable_columns
      @grid.visible_id = '1'
      @grid.visible_cached_credit = '1'
      @grid.visible_cached_debit = '1'
    end

  end

end
