class EmailTransaction < ActiveRecord::Base
  include BelongsToCreator
  include BelongsToSomebody
end
