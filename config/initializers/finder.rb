module Finder

  extend ActiveSupport::Concern

  module ClassMethods
    def finder id
      find id
    end
  end

end

ActiveRecord::Base.send(:include, Finder)
