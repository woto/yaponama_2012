# encoding: utf-8
#
module NotSelf
  extend ActiveSupport::Concern

  included do
    scope :not_self, ->(id){
      where.not(id: id) if id
    }
  end

end
