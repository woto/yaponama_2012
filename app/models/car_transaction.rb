class CarTransaction < ActiveRecord::Base
  include BelongsToCreator
  include BelongsToSomebody
end
