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
    read_only :confirm_required
    attr_accessor :force_confirm

    def force_confirm!
      @force_confirm = true
      confirmation_token_will_change!
    end

    def become_confirmed?
      confirmed_changed? && confirmed == true
    end

    def become_unconfirmed?
      confirmed_changed? && confirmed == false
    end

    def reset_confirmed
      self.confirmed = false
      generate_token(:confirmation_token, :short)
    end


    # new_record?
    # become_confirmed? / become_unconfirmed?
    # value_really_changed?
    # confirmed?
    # mobile?
    # confirm_required
    # TODO Написать правильную комбинацию
    before_validation if: -> {((confirm_required && value_really_changed?) || (!confirm_required && become_unconfirmed?)) } do
      force_confirm!
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
