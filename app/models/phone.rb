# encoding: utf-8
#
class Phone < ActiveRecord::Base
  include HiddenRecreate
  include BelongsToProfile
  include BelongsToCreator
  include Confirmed
  include NotSelf
  include BelongsToSomebody
  include Transactionable
  include Selectable
  include DestroyIfEmpty

  def self.mobile
    where(mobile: true)
  end

  belongs_to :profile, :inverse_of => :phones

  attr_accessor :hide_remove_button_on_first_on_new

  def hide_remove_button_on_first_on_new
    @hide_remove_button_on_first_on_new || 'false'
  end

  has_many :orders

  validates :value, presence: true, phone: true, unless: -> { self.marked_for_destruction? }

  validate :value do
    if Phone.confirmed.not_self(id).same(value).first
      errors.add(:value, "Такой номер телефона уже занят.")
      false
    end
  end

  scope :same, ->(value){ where("regexp_replace(value, '[^0-9]', '', 'g') = ?", value.gsub(/[^0-9]/, '')) if value }

  def value_really_changed
    value_changed? && ( value_was.to_s.gsub(/[^0-9]/, '') != value.to_s.gsub(/[^0-9]/, '') )
  end

  before_save do

    # Если стал подтвержденный, то удаляем остальные такие же
    if become_confirmed?
      Phone.not_self(id).same(value).destroy_all
    end

  end

  before_save do
    if value_really_changed && confirm_required || force_confirm
      # Телефон становится не подтвержденным.
      reset_confirmed
    end
  end

  after_save do
    if value_really_changed && confirm_required || force_confirm
      # Отправляем уведолмение
      ConfirmMailer.phone(self).deliver
    end
  end

  def to_label
    if mobile
      value.to_s.gsub(/(\d{3})(\d{3})(\d{2})(\d{2})/, '+7 (\1) \2-\3-\4')
    else
      value
    end
  end

  include RenameMeConcernTwo

  before_validation if: -> { ['register', 'chat'].include?(code_1) && !marked_for_destruction? }  do
    self.mobile = true
  end

  before_validation if: -> { ['register', 'chat', 'frontend'].include?(code_1) && mobile } do
    self.confirm_required = true
  end

  before_validation if: -> {['backend'].include?(code_1) && !confirmed && mobile } do
    self.confirm_required = true
  end

  before_validation if: -> { new_record? && !confirmed && mobile } do
    force_confirm!
  end

end
