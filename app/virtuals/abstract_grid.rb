class AbstractGrid
  include ActiveModel::Model

  def initialize(params)

    @item_ids = {}

    class << self

      COLUMNS.each do |column_name, column_settings|

        attr_accessor "visible_#{column_name}"
        #attr_accessor "filterable_#{column_name}"
        attr_accessor "filter_enabled_#{column_name}"

        case column_settings[:type]

          when *[:string, :catalog_number]
            attr_accessor "filter_#{column_name}_like"

          when :single_integer
            attr_accessor "filter_#{column_name}_single_integer"

          when :number
            attr_accessor "filter_#{column_name}_from"
            attr_accessor "filter_#{column_name}_to"

          when  :boolean
            attr_accessor "filter_#{column_name}_boolean"

          when  :checkbox
            attr_accessor "filter_#{column_name}_checkbox"

          when :set
            attr_accessor "filter_#{column_name}_set"

          when :belongs_to
            attr_accessor "filter_#{column_name}_belongs_to"

          when :date
            attr_accessor "filter_#{column_name}_from"
            attr_accessor "filter_#{column_name}_to"

          when :ip_address
            attr_accessor "filter_#{column_name}_ip_address"

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
