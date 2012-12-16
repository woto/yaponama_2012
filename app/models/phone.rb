#encoding: utf-8

class Phone < ActiveRecord::Base
  include PingCallback

  has_many :orders

  belongs_to :user, :validate => true
  validates :user, :presence => true

  attr_accessible :confirmed_by_human, :can_receive_sms, :notes, :phone, :notes_invisible, :user_id, :human_confirmation_datetime

  validates :can_receive_sms, :inclusion => { :in => ['Да', 'Нет', 'Неизвестно'] }
  validates :phone, :presence => true, :uniqueness => true
  validates :added_by, :inclusion => { :in => ['Покупателем', 'Менеджером'] }

  def to_label
    phone
  end

end
