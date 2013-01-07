# encoding: utf-8

supplier = Supplier.new(name: "8-я миля")
supplier.build_account
supplier.save!

supplier = Supplier.new(name: "Авториф")
supplier.build_account
supplier.save!

