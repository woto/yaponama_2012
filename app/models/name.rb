class Name < ActiveRecord::Base
  include BelongsToCreator
  include PingCallback

  has_many :orders

  validates :name, :presence => true

  belongs_to :user#, :validate => true
  validates :user, :presence => true

  #validates :name, :uniqueness => {:scope => :user_id}

  def to_label
    name
  end

end
