class Name < ActiveRecord::Base
  include PingCallback
  attr_accessible :name
  attr_accessible :notes, :notes_invisible, :user_id, :visible
  attr_accessible :created_at, :updated_at

  has_many :orders

  validates :name, :presence => true

  belongs_to :user#, :validate => true
  validates :user, :presence => true

  #validates :name, :uniqueness => {:scope => :user_id}

  def to_label
    name
  end

end
