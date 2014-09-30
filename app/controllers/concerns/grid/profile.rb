# encoding: utf-8
#
module Grid::Profile
  extend ActiveSupport::Concern
  include ::AbstractGridable

  included do

    private

    def adjust_columns!(columns_hash)

      c1(columns_hash) do
        columns_hash['cached_names'] = {
          :type => :string,
        }
        columns_hash['cached_phones'] = {
          :type => :string,
        }
        columns_hash['cached_emails'] = {
          :type => :string,
        }
        columns_hash['cached_passports'] = {
          :type => :string,
        }
      end
    end

    def set_preferable_columns
      super
      @grid.visible_cached_names = '1'
      @grid.visible_cached_phones = '1'
      @grid.visible_cached_emails = '1'
    end

  end

end
