class ProfileTransaction < ActiveRecord::Base
  include BelongsToCreator
  include BelongsToUser
end
