# encoding: utf-8
#
module RenameMeConcernTwo

  extend ActiveSupport::Concern

  included do
    include Code_1AttrAccessorAndValidation
    include CopyCode_1FromProfile
    include SetCreationReasonBasedOnCode_1
  end

end



