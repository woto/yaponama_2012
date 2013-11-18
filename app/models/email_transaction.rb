# encoding: utf-8
#
class EmailTransaction < ActiveRecord::Base
  include BelongsToCreator
  include BelongsToSomebody
end
