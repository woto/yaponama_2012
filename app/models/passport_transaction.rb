class PassportTransaction < ActiveRecord::Base
  include BelongsToCreator
  include BelongsToSomebody
end
