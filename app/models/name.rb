class Name < ActiveRecord::Base
  attr_accessible :name, :invisible
  belongs_to :user
  validates :name, :presence => true

  def to_label
    name
  end
end
