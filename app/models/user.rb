# encoding: utf-8
#
class User < Somebody

  validates :discount, :prepayment, :numericality => true
  validates :order_rule, :inclusion => { :in => Rails.configuration.somebody_order_rules.keys }

  validates :role, :inclusion => Rails.configuration.somebody_roles_keys

  before_validation if: -> {code_1 == 'register'} do
    self.password_required = true
  end

  before_save if: -> {code_1 == 'register'} do
    self.role = 'user'
  end

end
