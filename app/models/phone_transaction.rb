# encoding: utf-8
#
class PhoneTransaction < ActiveRecord::Base
  include BelongsToCreator
  include BelongsToSomebody
end
