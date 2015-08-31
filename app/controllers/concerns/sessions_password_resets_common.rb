# encoding: utf-8
#
module SessionsPasswordResetsCommon

  extend ActiveSupport::Concern

  included do

    private

    def session_password_resets_common old, new
      if params[:remember_me] == '1'
        cookies.permanent[:auth_token] = { :value => new.auth_token}
        cookies.permanent[:role] = new.role
      else
        cookies[:auth_token] = { :expire => nil, :value => new.auth_token } 
        cookies[:role] = new.role
      end

      # Переносим профили
      old.profile = nil
      old.save!

      old.profiles.each do |profile|
        profile.somebody = new
        profile.save!
      end

      # Переносим имена
      old.names.each do |name|
        name.somebody = new
        name.save!
      end

      # Переносим телефоны
      old.phones.each do |phone|
        phone.somebody = new
        phone.save!
      end

      # Переносим emails
      old.emails.each do |email|
        email.somebody = new
        email.save!
      end

      # Переносим паспорта
      old.passports.each do |passport|
        passport.somebody = new
        passport.save!
      end

      ##################

      # Переносим почтовые адреса
      old.postal_addresses.each do |postal_address|
        postal_address.somebody = new
        postal_address.save!
      end

      # Переносим компании
      old.companies.each do |company|
        company.somebody = new
        company.save!
      end

      # Переносим автомобили
      old.cars.each do |car|
        car.somebody = new
        car.save!
      end

      # Переносим заказы
      old.orders.each do |order|
        order.somebody = new
        order.save!
      end

      # Переносим товары
      old.products.each do |product|
        product.somebody = new
        product.save!
      end

      ##################
      
      #reset_session
      #session[:user_id] = authenticated.id
      # TODO Сделал так чтобы если пользователь зарегистрирован в системе, значит он имеет какие-то привилении
      # соответственно старный гостевой аккаунт не нужен и 'он не хотел под ним работать на сайте'
 
      if new.changes.present?
        binding.pry
      end

      if old.changes.present?
        binding.pry
      end

    end

  end

end
