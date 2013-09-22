class EmailTransaction < ActiveRecord::Base
  include BelongsToCreator
  include BelongsToUser
end
