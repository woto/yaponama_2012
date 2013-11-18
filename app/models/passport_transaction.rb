# encoding: utf-8
#
class PassportTransaction < ActiveRecord::Base
  include BelongsToCreator
  include BelongsToSomebody
end
