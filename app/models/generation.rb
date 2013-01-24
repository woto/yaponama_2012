class Generation < ActiveRecord::Base
  include BelongsToCreator
  belongs_to :model
  has_many :modifications, :dependent => :destroy
end
