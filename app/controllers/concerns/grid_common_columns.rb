# encoding: utf-8
#
module GridCommonColumns
  extend ActiveSupport::Concern

  included do
    def c2(columns_hash)

      id(columns_hash)

      yield

      creator_id(columns_hash)

      created_at(columns_hash)

      updated_at(columns_hash)

      phantom(columns_hash)

    end

    def c1(columns_hash)

      id(columns_hash)

      yield

      creation_reason(columns_hash)

      somebody_id(columns_hash)

      creator_id(columns_hash)

      created_at(columns_hash)

      updated_at(columns_hash)

      notes(columns_hash)

      notes_invisible(columns_hash)

    end


    def id(columns_hash)
      columns_hash['id'] = {
        :type => :single_integer
      }
    end

    def credit(columns_hash)
      columns_hash['credit'] = {
        :type => :number
      }
    end

    def debit(columns_hash)
      columns_hash['debit'] = {
        :type => :number
      }
    end

    def cached_brand(columns_hash)
      columns_hash['cached_brand'] = {
        :type => :string,
      }
    end

    def cached_model(columns_hash)
      columns_hash['cached_model'] = {
        :type => :string,
      }
    end

    def cached_generation(columns_hash)
      columns_hash['cached_generation'] = {
        :type => :string
      }
    end

    def cached_modification(columns_hash)
      columns_hash['cached_modification'] = {
        :type => :string,
      }
    end

    def name(columns_hash)
      columns_hash['name'] = {
        :type => :string,
      }
    end

    def somebody_id(columns_hash)
      if admin_zone?
        unless @somebody
          columns_hash['somebody_id'] = {
            :type => :belongs_to,
            :belongs_to => User,
          }
        end
      end
    end

    def creator_id(columns_hash)
      if admin_zone?
        columns_hash['creator_id'] = {
          :type => :belongs_to,
          :belongs_to => User,
        }
      end
    end

    def supplier_id(columns_hash)
      if admin_zone?
        columns_hash['supplier_id'] = {
          :type => :belongs_to,
          :belongs_to => Supplier,
        }
      end
    end

    def notes(columns_hash)
      columns_hash['notes'] = {
        :type => :string,
      }
    end

    def notes_invisible(columns_hash)
      if admin_zone?
        columns_hash['notes_invisible'] = {
          :type => :string,
        }
      end
    end

    def creation_reason(columns_hash)
      if admin_zone?
        columns_hash['creation_reason'] = {
          :type => :set,
          :set => eval("Hash[*Rails.configuration.#{@resource_class.name.underscore}_creation_reason.map{|k, v| [v, k]}.flatten]"),
        }
      end
    end

    def created_at(columns_hash)
      columns_hash['created_at'] = {
        :type => :date,
      }
    end

    def updated_at(columns_hash)
      columns_hash['updated_at'] = {
        :type => :date,
      }
    end

    def phantom(columns_hash)
      columns_hash['phantom'] = {
        :type => :boolean
      }
    end

  end

end

