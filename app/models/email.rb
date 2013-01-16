class Email < ActiveRecord::Base
  include PingCallback
  belongs_to :email_address
  has_many :attachments
  has_many :requests
end
