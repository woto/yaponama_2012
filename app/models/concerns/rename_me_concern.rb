# encoding: utf-8
#
module RenameMeConcern

  extend ActiveSupport::Concern

  included do
    include Code_1AttrAccessorAndValidation
    include CopyCode_1FromSomebody
    include SetCreationReasonBasedOnCode_1
  end

end
