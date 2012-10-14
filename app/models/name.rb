class Name < ActiveRecord::Base
  include PingCallback
  attr_accessible :name, :invisible, :user_id
  belongs_to :user
  validates :name, :presence => true

  def to_label
    name
  end
end
