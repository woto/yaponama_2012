# encoding: utf-8
#
module PasswordValidations

  extend ActiveSupport::Concern

  included do

    attr_accessor :password_required

    has_secure_password validations: false

    validates :password_confirmation,
      :presence => true,
      if: -> { password_required }

    validates :password,
      :presence => true,
      :confirmation => true,
      :length => { :minimum => 6 },
      if: -> { password_required }

  end

end
