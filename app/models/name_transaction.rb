class NameTransaction < ActiveRecord::Base
  include BelongsToCreator
  include BelongsToSomebody
end
