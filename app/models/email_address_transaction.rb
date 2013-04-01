class EmailAddressTransaction < ActiveRecord::Base
  include BelongsToCreator
  include BelongsToUser
end
