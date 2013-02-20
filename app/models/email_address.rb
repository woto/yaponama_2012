#encoding: utf-8

class EmailAddress < ActiveRecord::Base
  has_paper_trail
  include BelongsToUser
  include Confirmed
  include NotSelf

  has_many :emails
  VALID_EMAIL_REGEX = /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/
  # VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email_address, presence: true, format: {with: VALID_EMAIL_REGEX}

  validate :email_address do
    if EmailAddress.confirmed.not_self(id).same_email_address(email_address).first
      errors.add(:email_address, "Такой email уже занят")
      false
    end
  end

  scope :same_email_address, ->(email_address){ where('lower(email_address) = ?', email_address.downcase) if email_address }

  after_validation do
    # Если изменился email адрес, то он становится не подтвержденным.
    if persisted? && email_address_changed? && ( email_address_was.downcase != email_address.downcase )
      reset_confirmed
    end

    # TODO Что с уведомлением?
  end

  before_save do
    # Если подтвержденный, то удаляем остальные такие же
    if confirmed_changed?
      EmailAddress.not_self(id).same_email_address(email_address).destroy_all
    end

  end

  def to_label
    email_address
  end


end

#  validates :email_address, :format => {:with => /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/}
