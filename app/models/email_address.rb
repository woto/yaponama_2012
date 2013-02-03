#encoding: utf-8

class EmailAddress < ActiveRecord::Base
  include BelongsToUser
  include BelongsToCreator

  has_many :emails
  VALID_EMAIL_REGEX = /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/
  # VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email_address, :presence => true, :format => {with: VALID_EMAIL_REGEX}, :uniqueness => { case_sensitive: false }

  def to_label
    email_address
  end
end

#class EmailAddress < ActiveRecord::Base
#  belongs_to :user
#  validates :email_address, :format => {:with => /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/}
#end
#
