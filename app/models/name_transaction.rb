class NameTransaction < ActiveRecord::Base
  include BelongsToCreator
  include BelongsToUser
end
