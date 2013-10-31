class PageTransaction < ActiveRecord::Base
  include BelongsToCreator
  include BelongsToSomebody
end
