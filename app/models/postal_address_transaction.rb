class PostalAddressTransaction < ActiveRecord::Base
  include BelongsToCreator
  include BelongsToUser
end
