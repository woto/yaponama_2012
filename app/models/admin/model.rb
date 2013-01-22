class Admin::Model < ActiveRecord::Base
  include BelongsToCreator
  belongs_to :brand
end
