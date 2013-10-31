class CompanyTransaction < ActiveRecord::Base
  include BelongsToCreator
  include BelongsToSomebody
end
