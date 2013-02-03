class Name < ActiveRecord::Base
  include BelongsToUser
  include BelongsToCreator

  has_many :orders

  validates :name, :presence => true

  #validates :name, :uniqueness => {:scope => :user_id}

  def to_label
    name
  end

end
