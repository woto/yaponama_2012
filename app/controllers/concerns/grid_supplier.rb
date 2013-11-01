module GridSupplier

  extend ActiveSupport::Concern
  include AbstractGridable

  included do

    def adjust_columns!(columns_hash)

      id(columns_hash)

      columns_hash['cached_main_profile'] = {
        :type => :string
      }

      credit(columns_hash)
      debit(columns_hash)

      created_at(columns_hash)
      updated_at(columns_hash)
      phantom(columns_hash)

    end

    def set_preferable_columns
      @grid.visible_id = '1'
      @grid.visible_credit = '1'
      @grid.visible_debit = '1'
    end

  end

end