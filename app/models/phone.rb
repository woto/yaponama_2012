class Phone < ActiveRecord::Base
  include PingCallback

  has_many :orders, :inverse_of => :phone

  belongs_to :user, :inverse_of => :phones, :validate => true
  validates :user, :presence => true

  attr_accessible :confirmed_by_human, :can_receive_sms, :notes, :phone, :notes_invisible, :user_id, :human_confirmation_datetime

  validates :can_receive_sms, :inclusion => { :in => [true, false] }
  validates :phone, :presence => true, :uniqueness => true

  def to_label
    phone
  end

end
