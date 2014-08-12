# encoding: utf-8
#
class Session
  # ActiveModel
  include ActiveModel::Model
  # Тут явно что-то лишнее :)
  #include ActiveModel::Validations
  include ActiveModel::Dirty
  #extend ActiveModel::Translation

  # Application

  attr_accessor :value
  attr_accessor :user
  attr_accessor :password

  include MobileField
  validates :value, presence: true, phone: true, if: -> {code_2 == 'phone'}
  validates :value, presence: true, email: true, if: -> {code_2 == 'email' }

  validates :password, presence: true

  validate do

    authenticated_user = nil

    case code_2
    when 'phone'
      phones = Phone.where(value: value)
      phones.each do |phone|
        begin
          break if authenticated_user = phone.somebody.authenticate(password)
        rescue BCrypt::Errors::InvalidHash
        end
      end
    when 'email'
      eas = Email.where(:value => value)
      eas.each do |ea|
        begin
          break if authenticated_user = ea.somebody.authenticate(password)
        rescue BCrypt::Errors::InvalidHash
        end
      end
    end

    if authenticated_user
      if authenticated_user.logout_from_other_places?
        authenticated_user.generate_token :auth_token, :long
        authenticated_user.save!
      end
    else
      case code_2
      when 'phone'
        if self.errors.blank?
          errors.add(:base, "Указанные вами телефон и пароль не найдены, попробуйте еще раз, или воспользуйтесь восстановлением пароля.")
        end
      when 'email'
        if self.errors.blank?
          errors.add(:base, "Указанные вами телефон и пароль не найдены, попробуйте еще раз, или воспользуйтесь восстановлением пароля.")
        end
      end
    end

    self.user = authenticated_user
    #return !!authenticated_user

  end

  ########################################################################

  attr_accessor :code_2

  validates :code_2, presence: true, inclusion: { in: ['phone', 'email'] }

end
