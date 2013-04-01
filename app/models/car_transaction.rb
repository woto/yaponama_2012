class CarTransaction < ActiveRecord::Base
  include BelongsToCreator
  include BelongsToUser
end
