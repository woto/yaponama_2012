# encoding: utf-8
#
class BlockTransaction < ActiveRecord::Base
  include BelongsToCreator
  include BelongsToSomebody
end

