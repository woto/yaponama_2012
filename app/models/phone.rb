class Phone < ActiveRecord::Base

  include HiddenRecreate
  include BelongsToProfile
  include BelongsToCreator
  include Confirmed
  include NotSelf
  include BelongsToSomebody
  include Transactionable
  include Selectable

  read_only :creation_reason
  read_only :mobile

  belongs_to :profile, :inverse_of => :phones

  has_many :orders

  validates :value, presence: true, phone: true, unless: -> { self.marked_for_destruction? }

  validate :value do
    if Phone.where(confirmed: true).not_self(id).same(value).first
      errors.add(:value, "Такой номер телефона уже занят.")
      false
    end
  end

  scope :same, ->(value){ where("regexp_replace(value, '[^0-9]', '', 'g') = ?", value.gsub(/[^0-9]/, '')) if value }

  def value_really_changed?
    value_changed? && ( value_was.to_s.gsub(/[^0-9]/, '') != value.to_s.gsub(/[^0-9]/, '') )
  end

  def force_confirm_condition
    become_unconfirmed? && mobile?
  end

  def remove_same
    Phone.not_self(id).same(value).destroy_all
  end

  def deliver_confirmation
    ConfirmMailer.phone(self).deliver_now
  end

  def to_label
    if mobile
      value.to_s.gsub(/(\d{3})(\d{3})(\d{2})(\d{2})/, '+7 (\1) \2-\3-\4')
    else
      value
    end
  end

end
