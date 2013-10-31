class Block < ActiveRecord::Base
  include Transactionable
  include BelongsToCreator
  include Transactionable
  include Selectable
end
