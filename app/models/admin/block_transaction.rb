class Admin::BlockTransaction < ActiveRecord::Base
  include BelongsToCreator
  include BelongsToSomebody
end

