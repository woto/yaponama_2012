# encoding: utf-8
#
class Email < ActiveRecord::Base
  include HiddenRecreate
  include BelongsToProfile
  include BelongsToCreator
  include Confirmed
  include NotSelf
  include BelongsToSomebody
  include Transactionable
  include Selectable

  belongs_to :profile, :inverse_of => :emails

  has_many :letters, class_name: "Talkables::Letters"

  validates :value, presence: true, email: true, unless: -> { self.marked_for_destruction? }

  validate :value do
    if Email.confirmed.not_self(id).same(value).first
      errors.add(:value, "Такой e-mail адрес уже занят.")
      false
    end
  end

  scope :same, ->(value){ where('lower(value) = ?', value.downcase) if value }

  def value_really_changed
    value_changed? && ( value_was.to_s.downcase != value.to_s.downcase )
  end

  before_save do

    # Если стал подтвержденный, то удаляем остальные такие же
    if become_confirmed?
      Email.not_self(id).same(value).destroy_all
    end

  end

  before_save do
    if value_really_changed && confirm_required || force_confirm
      # Адрес становится не подтвержденным.
      reset_confirmed
    end
  end

  after_save do
    if value_really_changed && confirm_required || force_confirm
      # Отправляем уведомление
      ConfirmMailer.email(self).deliver
    end
  end

  def to_label
    value
  end

  include RenameMeConcernTwo
  include DestroyIfEmpty

  before_validation if: -> { ['register', 'chat', 'frontend'].include?(code_1) }  do
    self.confirm_required = true
  end

  before_validation if: -> {['backend'].include?(code_1) && !confirmed } do
    self.confirm_required = true
  end

  before_validation if: -> { new_record? && !confirmed } do
    force_confirm!
  end

end
