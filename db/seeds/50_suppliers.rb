# encoding: utf-8
#
#rrda
supplier = Supplier.new(Rails.application.config_for('application/user')['default'])
supplier.build_account
supplier.code_1 = 'seed'
supplier.save!

#rrda
supplier = Supplier.new(Rails.application.config_for('application/user')['default'])
supplier.build_account
supplier.code_1 = 'seed'
supplier.save!

