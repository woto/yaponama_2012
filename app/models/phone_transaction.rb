class PhoneTransaction < ActiveRecord::Base
  include BelongsToCreator
  include BelongsToSomebody
end
