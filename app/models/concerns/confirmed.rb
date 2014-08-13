module Confirmed
  include Tokenable
  extend ActiveSupport::Concern

  included do

    attr_accessor :pin
    attr_accessor :pin_required

    validates :pin, presence: true, if: -> { pin_required }

    validate if: -> { pin_required && errors.empty? } do
      if pin != confirmation_token
        errors.add(:pin, 'указан неверный PIN код.')
      else
        self.confirmation_token = ''
        self.confirmed = true
      end
    end

    read_only :confirmed
    # TODO Более не нужно
    read_only :admin_zone

    # Мы не передаем флаг confirmed из страницы редактирования профиля
    # в фронтенде или страницы регистрации и полагаемся только на реальное 
    # изменение value ЭТО НЕ ТАК. МЫ ПЕРЕДАЕМ CONFIRMED NIL
    before_validation if: -> { confirmed.nil? } do
      if value_really_changed?
        self.confirmed = false
      else
        # Сначала мы пытаемся считать старое значение, если не получается
        # то помечаем как не подтвержденный
        self.confirmed = confirmed_was || false
      end
      true
    end

    attr_accessor :force_confirm

    before_validation if: :force_confirm_condition do
      force_confirm!
    end

    def force_confirm!
      self.force_confirm = true
      confirmation_token_will_change!
    end


    # TODO Странно, я передаю из фронтенда nil, валидация прокатывает?
    validates :confirmed, inclusion: [true, false]

    def become_confirmed?
      confirmed_changed? && confirmed == true
    end

    def become_unconfirmed?
      confirmed_changed? && confirmed == false
    end

    before_save if: :force_confirm do
      self.confirmed = false
      generate_token(:confirmation_token, :short)
    end

    # Отправляем уведомление
    after_save if: :force_confirm  do
      deliver_confirmation
    end

    # Если стал подтвержденный, то удаляем остальные такие же
    before_save if: :become_confirmed? do
      remove_same
    end

  end

  module ClassMethods

    #def confirmed
    #  where(confirmed: true)
    #end

    #def not_confirmed
    #  where(confirmed: false)
    #end

  end

end
