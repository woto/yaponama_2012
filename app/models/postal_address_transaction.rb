# encoding: utf-8
#
class PostalAddressTransaction < ActiveRecord::Base
  include BelongsToCreator
  include BelongsToSomebody
end
