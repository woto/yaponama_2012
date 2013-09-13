module RenameMeConcern

  extend ActiveSupport::Concern

  included do
    include Code_1AttrAccessorAndValidation
    include CopyCode_1FromUser
    include SetCreationReasonBasedOnCode_1
  end

end
