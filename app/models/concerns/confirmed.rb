# encoding: utf-8
#
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

    attr_accessor :confirm_required
    attr_accessor :force_confirm

    def force_confirm!
      @force_confirm = true
      confirmation_token_will_change!
    end

    def become_confirmed?
      confirmed_was.blank? && confirmed.present?
    end

    def reset_confirmed
      self.confirmed = false
      generate_token(:confirmation_token, :short)
    end


  end

  module ClassMethods

    def confirmed
      where(confirmed: true)
    end

    def not_confirmed
      where(confirmed: false)
    end

  end

end
