class PassportTransaction < ActiveRecord::Base
  include BelongsToCreator
  include BelongsToUser
end
