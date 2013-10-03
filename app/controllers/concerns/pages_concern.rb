#encoding: utf-8

module PagesConcern
  extend ActiveSupport::Concern
  include AbstractGridable

  included do

    def set_grid_class

      @grid_class = Class.new(AbstractGrid)

      @grid_class.instance_eval do
        include ActiveModel::Validations
        def self.model_name
          ActiveModel::Name.new(self, nil, 'grid')
        end
      end

      columns_hash = {}

      columns_hash['checkbox'] = {
        :type => :checkbox,
      }

      columns_hash['id'] = {
        :type => :single_integer
      }

      columns_hash['path'] = {
        :type => :string,
      }

      columns_hash['content'] = {
        :type => :string,
      }

      columns_hash['keywords'] = {
        :type => :string,
      }

      columns_hash['description'] = {
        :type => :string,
      }

      columns_hash['title'] = {
        :type => :string,
      }

      columns_hash['robots'] = {
        :type => :string,
      }

      columns_hash['creator_id'] = {
        :type => :belongs_to,
        :belongs_to => User,
      }

      columns_hash['created_at'] = {
        :type => :date,
      }

      columns_hash['updated_at'] = {
        :type => :date,
      }

      @grid_class.const_set("COLUMNS", columns_hash)

    end

    def set_resource_class
      @resource_class = Page
    end

    def set_preferable_columns
      @grid.checkbox_visible = '1'
      @grid.path_visible = '1'
      @grid.path_visible = '1'
      @grid.content_visible = '1'
      @grid.keywords_visible = '1'
      @grid.description_visible = '1'
      @grid.title_visible = '1'
      @grid.robots_visible = '1'
      @grid.creator_id_visible = '1'
      @grid.created_at_visible = '1'
      @grid.updated_at_visible = '1'

    end

  end

end
