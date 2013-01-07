# encoding: utf-8

user = User.new
user.build_account
user.account.assign_attributes( {:debit => 0, :credit => 0}, :without_protection => true )
user.assign_attributes( Rails.configuration.default_user_attributes, :without_protection => true )
user.role = "admin"
user.password = '1111111111'
phone = user.phones.build
phone.assign_attributes({:phone => '1111111111', :phone_type => 'mobile_russia'}, :without_protection => true)
email_address = user.email_addresses.build
email_address.assign_attributes({:email_address => 'demo@example.com'}, :without_protection => true)
user.save!
