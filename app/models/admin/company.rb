class Admin::Company < ActiveRecord::Base
  attr_accessible :account, :bank_account, :bic, :correspondent_account, :inn, :kpp, :name
end
