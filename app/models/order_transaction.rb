class OrderTransaction < ActiveRecord::Base
  include BelongsToCreator
  include BelongsToSomebody
end
