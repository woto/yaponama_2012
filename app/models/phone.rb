#encoding: utf-8

class Phone < ActiveRecord::Base
  include PingCallback
  include BelongsToCreator

  has_many :orders

  belongs_to :user#, :validate => true
  validates :user, :presence => true


  attr_accessible :confirmed_by_human, :can_receive_sms, :notes, :phone, :notes_invisible, :user_id, :human_confirmation_datetime, :as => [:admin, :manager, :user, :guest]

  validates :can_receive_sms, :inclusion => { :in => Rails.configuration.user_phone_can_receive_sms.keys }
  validates :phone, :presence => true, :uniqueness => true

  def to_label
    phone
  end

end
