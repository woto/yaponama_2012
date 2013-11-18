# encoding: utf-8
#
module NewResourceDummy

  extend ActiveSupport::Concern

  included do

    def new_resource
      @resource_class = nil
    end

  end

end

