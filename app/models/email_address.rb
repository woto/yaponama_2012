class EmailAddress < ActiveRecord::Base
  include PingCallback
  belongs_to :user, :inverse_of => :email_addresses
  attr_accessible :confirmed_by_human, :email_address, :invisible, :user_id, :human_confirmation_datetime 
  validates :user, :presence => true
  has_many :emails
  #validates :email_address, :presence => true, :uniqueness => true
  

  def to_label
    email_address
  end
end
