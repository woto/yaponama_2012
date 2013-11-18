# encoding: utf-8
#
module GridPassport
  extend ActiveSupport::Concern
  include AbstractGridable

  included do

    def adjust_columns!(columns_hash)

      c1(columns_hash) do

        columns_hash['seriya'] = {
          :type => :string,
        }
        columns_hash['nomer'] = {
          :type => :string,
        }
        columns_hash['passport_vidan'] = {
          :type => :string,
        }
        columns_hash['data_vidachi'] = {
          :type => :date,
        }
        columns_hash['kod_podrazdeleniya'] = {
          :type => :string,
        }
        columns_hash['gender'] = {
          :type => :set,
          :set => Hash[*Rails.configuration.genders.map{|k, v| [v, k]}.flatten],
        }
        columns_hash['data_rozhdeniya'] = {
          :type => :date,
        }
        columns_hash['mesto_rozhdeniya'] = {
          :type => :string,
        }

      end

    end

    def set_preferable_columns
      super
      @grid.visible_seriya = '1'
      @grid.visible_nomer = '1'
      @grid.visible_passport_vidan = '1'
      @grid.visible_mesto_rozhdeniya = '1'
    end

  end

end
