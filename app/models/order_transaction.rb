# encoding: utf-8
#
class OrderTransaction < ActiveRecord::Base
  include BelongsToCreator
  include BelongsToSomebody
end
