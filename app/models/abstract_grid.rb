# encoding: utf-8
#
class AbstractGrid
  include ActiveModel::Model
  #extend ActiveModel::Naming

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
            attr_accessor :temp_from
            attr_accessor :temp_to

            1.upto 5 do |i|
              define_method "filter_#{column_name}_from(#{i}i)=" do |arg|
                self.temp_from ||= {}
                self.temp_from[i] = arg
                if self.temp_from.length == 5
                  instance_variable_set :"@filter_#{column_name}_from", DateTime.new(self.temp_from[1].to_i, self.temp_from[2].to_i, self.temp_from[3].to_i, self.temp_from[4].to_i, self.temp_from[5].to_i)
                end
              end
            end

            1.upto 5 do |i|
              define_method "filter_#{column_name}_to(#{i}i)=" do |arg|
                self.temp_to ||= {}
                self.temp_to[i] = arg
                if self.temp_to.length == 5
                  instance_variable_set :"@filter_#{column_name}_to", DateTime.new(self.temp_to[1].to_i, self.temp_to[2].to_i, self.temp_to[3].to_i, self.temp_to[4].to_i, self.temp_to[5].to_i)
                end
                  
              end
            end

            attr_accessor "filter_#{column_name}_from"
            attr_accessor "filter_#{column_name}_to"

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
