class PhoneTransaction < ActiveRecord::Base
  include BelongsToCreator
  include BelongsToUser
end
