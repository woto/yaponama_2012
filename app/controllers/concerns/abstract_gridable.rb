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
      raise 'set_grid_class'
    end

    include GridConcern

  end

end
