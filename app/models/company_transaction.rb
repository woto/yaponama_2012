class CompanyTransaction < ActiveRecord::Base
  include BelongsToCreator
  include BelongsToUser
end
