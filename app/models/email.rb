class Email < ActiveRecord::Base
  include BelongsToUser
  belongs_to :email_address
  has_many :attachments
  has_many :requests
end
