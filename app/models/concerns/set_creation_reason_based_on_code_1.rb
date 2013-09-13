module SetCreationReasonBasedOnCode_1
  extend ActiveSupport::Concern

  included do

    before_validation if: -> {code_1.present?}, on: :create do
      self.creation_reason = code_1
    end

  end

end
