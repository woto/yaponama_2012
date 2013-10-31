class PostalAddressTransaction < ActiveRecord::Base
  include BelongsToCreator
  include BelongsToSomebody
end
