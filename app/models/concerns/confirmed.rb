#encoding: utf-8

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
        self.confirmed_by_user = true
      end
    end

  end

  module ClassMethods

    def confirmed
      where(( arel_table[:confirmed_by_user].eq(true) ).or( arel_table[:confirmed_by_manager].eq(true) ))
    end

    def not_confirmed
      where(( arel_table[:confirmed_by_user].eq(false) ).and( arel_table[:confirmed_by_manager].eq(false) ))
    end

  end

  def confirmed?
    confirmed_by_user || confirmed_by_manager
  end

  def become_confirmed?
    ( confirmed_by_user_was.blank? && confirmed_by_user.present? ) || (confirmed_by_manager_was.blank? && confirmed_by_manager.present? )
  end

  def reset_confirmed
    self.confirmed_by_user = false
    self.confirmed_by_manager = false
    generate_token(:confirmation_token, :short)
  end

end
