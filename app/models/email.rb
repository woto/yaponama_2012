class Email < ActiveRecord::Base
  include HiddenRecreate
  include BelongsToProfile
  include BelongsToCreator
  include Confirmed
  include NotSelf
  include BelongsToSomebody
  include Transactionable
  include Selectable

  read_only :creation_reason

  belongs_to :profile, :inverse_of => :emails

  validates :value, presence: true, email: true, unless: -> { self.marked_for_destruction? }

  validate :value do
    if Email.where(confirmed: true).not_self(id).same(value).first
      errors.add(:value, "Такой e-mail адрес уже занят.")
      false
    end
  end

  scope :same, ->(value){ where('lower(value) = ?', value.downcase) if value }

  def value_really_changed?
    value_changed? && ( value_was.to_s.downcase != value.to_s.downcase )
  end

  def force_confirm_condition
    become_unconfirmed?
  end

  def remove_same
    Email.not_self(id).same(value).destroy_all
  end

  def deliver_confirmation
    ConfirmMailer.email(self).deliver_now
  end

  def to_label
    value
  end

end
