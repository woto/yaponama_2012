# encoding: utf-8
#
class PageTransaction < ActiveRecord::Base
  include BelongsToCreator
  include BelongsToSomebody
end
