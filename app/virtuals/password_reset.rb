# encoding: utf-8
#
class PasswordReset
  include ActiveModel::Model
  include ActiveModel::Dirty
  include ActiveModel::Validations::Callbacks
  include ActiveModel::SecurePassword

  attr_accessor :value
  attr_accessor :somebody

  include MobileField
  validates :value, presence: true, phone: true, if: -> {with == 'phone' }
  validates :value, presence: true, email: true, if: -> {with == 'email' }

  # TODO Защититься
  #MAX_ATTEMPTS = 7
  #LOCK_TIME = 1.hours


  validate do

    case with 

    when 'email'
      contact = Email.where(confirmed: true).find_by_value(value)
    when 'phone'
      contact = Phone.where(confirmed: true, mobile: true).find_by_value(value)
    end

    if contact.present?
      @somebody = contact.somebody
    else
      if errors.blank?
        errors.add(:base, "Мы не смогли найти среди зарегистрированных покупателей указанные вами данные, проверьте ввод и попробуйте еще раз, или свяжитесь с службой поддержки.")
      end
    end

  end

  ########################################################################
 
  attr_accessor :pin
  attr_accessor :pin_required

  validate if: -> { pin_required && self.errors.none? } do

    if @somebody.password_reset_token != pin
      errors.add(:pin, 'Указан неверный PIN код.')
      # TODO защититься
      #@user.password_reset_attempts = @user.password_reset_attempts + 1
      #@user.save!
    elsif @somebody.password_reset_sent_at < 2.hours.ago
      errors.add(:base, 'В целях безопасности ваша инструкция по восстановлению пароля была признана устаревшей, пожалуйста запросите новую.')
    end

  end

  ########################################################################

  attr_accessor :with

  validates :with, presence: true, inclusion: { in: ['phone', 'email'] }

  before_validation do 
    if with == 'phone'
      # Восстановить пароль можно только с помощью номера мобильного телефона. 
      # UPD: (Не обязательно, для прохождения валидации.)
      self.mobile = true
    end
  end

  ########################################################################
  
  attr_accessor :password_digest
  include PasswordValidations

end
