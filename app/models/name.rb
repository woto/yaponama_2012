class Name < ActiveRecord::Base
  include BelongsToCreator
  include PingCallback
  attr_accessible :name, :as => [:admin, :manager, :user]
  attr_accessible :notes, :notes_invisible, :user_id, :visible, :as => [:admin, :manager, :user]
  attr_accessible :created_at, :updated_at, :as => [:admin, :manager, :user]

  has_many :orders

  validates :name, :presence => true

  belongs_to :user#, :validate => true
  validates :user, :presence => true

  #validates :name, :uniqueness => {:scope => :user_id}

  def to_label
    name
  end

end
