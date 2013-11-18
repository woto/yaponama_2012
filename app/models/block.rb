# encoding: utf-8
#
class Block < ActiveRecord::Base
  include Transactionable
  include BelongsToCreator
  include Transactionable
  include Selectable
end
