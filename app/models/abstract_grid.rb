class AbstractGrid
  include ActiveModel::Model

  def initialize(params)

    @item_ids = {}

    class << self

      COLUMNS.each do |column_name, column_settings|

        attr_accessor "#{column_name}_visible"
        attr_accessor "#{column_name}_filterable"

        case column_settings[:type]

          when :string
            attr_accessor "#{column_name}_like"

          when :number
            attr_accessor "#{column_name}_from"
            attr_accessor "#{column_name}_to"

          when  :boolean
            attr_accessor "#{column_name}_boolean"

          when :set
            attr_accessor "#{column_name}_set"

          when :belongs_to
            attr_accessor "#{column_name}_belongs_to"

          when :date
            attr_accessor "#{column_name}_from"
            attr_accessor "#{column_name}_to"

        end

      end

      attr_accessor 'sort_column'
      attr_accessor 'sort_direction'
      attr_accessor 'page'
      attr_accessor 'per_page'
      attr_accessor 'item_ids'

    end

    super(params)

  end

end
