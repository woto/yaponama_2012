#encoding: utf-8

class Phone < ActiveRecord::Base
  has_paper_trail
  include BelongsToUser
  include Confirmed
  include NotSelf

  has_many :orders

  validates :phone_type, :inclusion => { :in => Rails.configuration.phone_types_keys }

  validates :phone, presence: true
  validates :phone, :numericality => { :only_integer => true }, :length => { :within => 10..10 }, :if => Proc.new{ phone_type == 'mobile_russia' }
  

  validate :phone do
    if Phone.confirmed.not_self(id).same_phone(phone).first
      errors.add(:phone, "Такой номер телефона уже занят")
      false
    end
  end

  after_validation do
    # Если изменился номер телефона, то он становится не подтвержденным.
    if  persisted? && phone_changed? && ( phone_was.gsub(/[^0-9]/, '') != phone.gsub(/[^0-9]/, '') )
      reset_confirmed
    end

    # TODO Что с уведомлением?
  end


  before_save do
    # Если подтвержденный, то удаляем остальные такие же
    if confirmed_changed?
      Phone.not_self(id).same_phone(phone).destroy_all
    end
  end

  scope :same_phone, ->(phone){ where("regexp_replace(phone, '[^0-9]', '', 'g') = ?", phone.gsub(/[^0-9]/, '')) if phone }

  def to_label
    if phone_type == 'mobile_russia'
      phone.gsub(/(\d{3})(\d{3})(\d{2})(\d{2})/, '+7 (\1) \2-\3-\4')
    else
      phone
    end
  end

end
