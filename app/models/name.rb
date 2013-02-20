class Name < ActiveRecord::Base
  has_paper_trail
  include BelongsToUser

  has_many :orders

  validates :name, :presence => true

  #validates :name, :uniqueness => {:scope => :user_id}

  def to_label
    name
  end

end
