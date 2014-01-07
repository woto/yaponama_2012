# encoding: utf-8
#
#rrda
supplier = Supplier.new(SiteConfig.default_somebody_attributes)
supplier.build_account
supplier.code_1 = 'seed'
supplier.save!

#rrda
supplier = Supplier.new(SiteConfig.default_somebody_attributes)
supplier.build_account
supplier.code_1 = 'seed'
supplier.save!

