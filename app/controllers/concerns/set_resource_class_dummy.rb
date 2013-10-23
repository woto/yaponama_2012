module SetResourceClassDummy

  extend ActiveSupport::Concern

  included do

    def set_resource_class
      @resource_class = nil
    end

  end

end
