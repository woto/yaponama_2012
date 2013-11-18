# encoding: utf-8
#
class NameTransaction < ActiveRecord::Base
  include BelongsToCreator
  include BelongsToSomebody
end
