class OrderTransaction < ActiveRecord::Base
  include BelongsToCreator
  include BelongsToUser
end
