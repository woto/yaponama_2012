class MoveSomebodiesToUsers < ActiveRecord::Migration
  def change
    reversible do |dir|
      dir.up do
        Somebody.update_all(type: "Somebody")
        PostalAddress.where(room: "").update_all(stand_alone_house: true)
        Car.joins(:brand).each{|c| c.brand.update(:is_brand => true)}
        Somebody.joins(:emails).find_each do |somebody|
          begin
          User.create!(
            role: User.roles[somebody.role],
            encrypted_password: somebody.password_digest,
            ipgeobase_name: somebody.ipgeobase_name,
            ipgeobase_names_depth_cache: somebody.ipgeobase_names_depth_cache,
            accept_language: somebody.accept_language,
            user_agent: somebody.user_agent,
            current_sign_in_ip: somebody.remote_ip,
            location: somebody.location,
            referrer: somebody.referrer,
            first_referrer: somebody.first_referrer,
            email: somebody.emails.first.try(:value) || loop { res = Email.exists?(email = "fake_#{rand(1000000000)}.example.com"); break email unless res} ,
            debit: somebody.account.try(:debit),
            credit: somebody.account.try(:credit),
            name: (v = somebody.names.first) && [v.try(:surname), v.try(:name), v.try(:patronymic)].reject(&:blank?).join(' '),
            phone: somebody.phones.first.try(:value),
            email: somebody.emails.first.try(:value), 
            password: '12345678',
            cars: somebody.cars,
            postal_addresses: somebody.postal_addresses,
            orders: somebody.orders,
            products: somebody.products
          ) unless User.exists?(email: somebody.emails.first.try(:value))
          rescue ActiveRecord::RecordInvalid
            puts somebody.id
          end
        end
      end
    end
  end
end
