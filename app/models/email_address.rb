#encoding: utf-8

class EmailAddress < ActiveRecord::Base
  include BelongsToCreator
  include PingCallback

  attr_accessible :notes, :notes_invisible, :as => [:admin, :manager, :user]
  attr_accessible :confirmed_by_human, :email_address, :user_id, :human_confirmation_datetime, :visible, :as => [:admin, :manager, :user, :guest]

  #validates :user, :presence => true

  belongs_to :user#, :validate => true
  validates :user, :presence => true

  has_many :emails
  VALID_EMAIL_REGEX = /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/
  # VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email_address, :presence => true, :format => {with: VALID_EMAIL_REGEX}, :uniqueness => { case_sensitive: false }

  def to_label
    email_address
  end
end

#class EmailAddress < ActiveRecord::Base
#  attr_accessible :email_address
#  attr_accessible :confirmed_by_human, :human_confirmation_datetime, :notes_invisible
#
#  belongs_to :user
#  validates :email_address, :format => {:with => /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/}
#end
