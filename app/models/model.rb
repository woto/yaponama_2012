class Model < ActiveRecord::Base
  include BelongsToCreator
  belongs_to :brand
  has_many :generations, :dependent => :destroy
end
