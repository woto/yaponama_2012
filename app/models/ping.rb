class Ping < ActiveRecord::Base
  belongs_to :user
  # TODO check needed?
  validates :user, :presence => true
end
