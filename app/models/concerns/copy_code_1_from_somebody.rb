# encoding: utf-8
#
module CopyCode_1FromSomebody
  extend ActiveSupport::Concern

  included do
    before_validation if: -> {somebody && somebody.code_1.present?} do
      self.code_1 = somebody.code_1
    end
  end

end
