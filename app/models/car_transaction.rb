# encoding: utf-8
#
class CarTransaction < ActiveRecord::Base
  include BelongsToCreator
  include BelongsToSomebody
end
