# encoding: utf-8
#
class CompanyTransaction < ActiveRecord::Base
  include BelongsToCreator
  include BelongsToSomebody
end
