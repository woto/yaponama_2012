module CopyCode_1FromUser
  extend ActiveSupport::Concern

  included do
    before_validation if: -> {user && user.code_1.present?} do
      self.code_1 = user.code_1
    end
  end

end
