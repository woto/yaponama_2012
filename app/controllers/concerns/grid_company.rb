# encoding: utf-8
#
module GridCompany

  extend ActiveSupport::Concern
  include AbstractGridable

  included do
    def adjust_columns!(columns_hash)

      c1(columns_hash) do

        columns_hash['ownership'] = {
          :type => :set,
          :set => Hash[*Rails.configuration.company_ownerships.map{|k, v| [v, k]}.flatten],
        }
        columns_hash['name'] = {
          type: :string
        }
        columns_hash['inn'] = {
          type: :string
        }
        columns_hash['kpp'] = {
          type: :string
        }
        columns_hash['ogrn'] = {
          type: :string
        }
        columns_hash['account'] = {
          type: :string
        }
        columns_hash['bank'] = {
          type: :string
        }
        columns_hash['bik'] = {
          type: :string
        }
        columns_hash['correspondent'] = {
          :type => :string,
        }
        columns_hash['okpo'] = {
          :type => :string,
        }
        columns_hash['okved'] = {
          :type => :string,
        }
        columns_hash['okato'] = {
          :type => :string,
        }
        columns_hash['cached_legal_address'] = {
          :type => :string,
        }
        columns_hash['cached_actual_address'] = {
          :type => :string,
        }

      end

    end

    def set_preferable_columns
      super
      @grid.visible_inn = '1'
      @grid.visible_name = '1'
      @grid.visible_ogrn = '1'
      @grid.visible_ownership = '1'
      @grid.visible_cached_legal_address = '1'
      @grid.visible_cached_actual_address = '1'
    end

  end

end

