# encoding: utf-8
#
module CopyCode_1FromProfile
  extend ActiveSupport::Concern

  included do
    before_validation if: -> {profile && profile.code_1.present?} do
      self.code_1 = profile.code_1
    end
  end

end
