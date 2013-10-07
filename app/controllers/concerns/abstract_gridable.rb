#encoding: utf-8

module AbstractGridable
  extend ActiveSupport::Concern

  included do
    before_action :set_resource_class
    before_action :set_grid_class

    def set_resource_class
      raise 'set_resource_class'
    end

    def set_grid_class
      @grid_class = Class.new(AbstractGrid)

      @grid_class.instance_eval do
        include ActiveModel::Validations
        def self.model_name
          ActiveModel::Name.new(self, nil, "grid")
        end
      end

      columns_hash = {}

      adjust_columns!(columns_hash)

      @grid_class.const_set("COLUMNS", columns_hash)
    end


    # Проверка выделения хотя бы одной позиции
    def any_checked_validation
      if @items.blank?
        raise ValidationError.new "Ни одна позиция не выделена"
      end
    end


    def one_checked_validation
      if @items.size != 1
        raise ValidationError.new "Для данной операции необходимо чтобы была выделена только 1 позиция."
      end
    end

    include GridConcern

  end

end
