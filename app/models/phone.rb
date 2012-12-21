#encoding: utf-8

class Phone < ActiveRecord::Base
  include PingCallback
  include BelongsToCreator

  has_many :orders

  belongs_to :user#, :validate => true
  validates :user, :presence => true

  attr_accessible :confirmed_by_human, :phone_type, :notes, :phone, :notes_invisible, :user_id, :human_confirmation_datetime, :as => [:admin, :manager, :user, :guest]

  validates :phone_type, :inclusion => { :in => Rails.configuration.phone_types.keys }

  validates :phone, :presence => true, :uniqueness => true
  validates :phone, :numericality => { :only_integer => true }, :length => { :within => 10..10 }, :if => Proc.new{ phone_type == 'mobile_russia' }

  def to_label
    if phone_type == 'mobile_russia'
      phone.gsub(/(\d{3})(\d{3})(\d{2})(\d{2})/, '+7 (\1) \2-\3-\4')
    else
      phone
    end
  end

end
