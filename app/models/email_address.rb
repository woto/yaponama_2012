class EmailAddress < ActiveRecord::Base
  include PingCallback
  belongs_to :user, :inverse_of => :email_addresses
  attr_accessible :confirmed_by_human, :email_address, :invisible, :user_id, :human_confirmation_datetime 
  validates :email_address, :presence => true
  validates :user, :presence => true

  def to_label
    email_address
  end
end
