class Name < ActiveRecord::Base
  include PingCallback
  attr_accessible :name, :notes_invisible, :user_id, :visible
  belongs_to :user
  has_many :orders, :inverse_of => :name
  validates :name, :presence => true
  #validates :name, :uniqueness => {:scope => :user_id}

  def to_label
    name
  end
end
