# encoding: utf-8
#
require 'test_helper'
require 'integration/attributes/user_profile_attributes'
require 'integration/attributes/changed_user_profile_attributes'

class TransactionsTest < ActionDispatch::IntegrationTest
  include UserProfileAttributes
  include ChangedUserProfileAttributes

  test 'Если покупатель создает новый профиль из имени, телефона, эл. почты и паспорта, то в созданных транзакциях мы убеждаемся, что: У всех выставляется операция create, у всех выставляется правильно создатель и владелец причина создания profile. И дополнительно у всех дочерних правильно указан родительский профиль. Аналогично далее делаем проверку от лица администратора, изменяя все данные. И в конце удаляем от пользователя' do
    
    authenticated_as '+7 (123) 123-12-31', '1231231231' do |sess|

      post user_profiles_path, { resource_class: 'Profile' }.merge(user_profile_attributes)

      ['name', 'phone', 'email', 'passport', 'profile'].each do |profileable|
        instance_eval <<-CODE, __FILE__, __LINE__ + 1

          assert_equal 'create', #{profileable.camelize}Transaction.last.operation
          assert_equal #{profileable.camelize}Transaction.last.creator_id, somebodies(:first_user).id
          #assert_equal #{profileable.camelize}Transaction.last.somebody_id, somebodies(:first_user).id

          if profileable != 'profile'
            assert_equal #{profileable.camelize}Transaction.last.profile_id_after, Profile.last.id
            assert_equal 'frontend', assigns(:resource).#{profileable.pluralize}.first.creation_reason 
          else
            assert_equal 'frontend', assigns(:resource).creation_reason
          end

        CODE
      end
    end

    authenticated_as '+7 (111) 111-11-11', '1111111111' do |sess|
      request = { resource_class: 'Profile' }.merge(changed_user_profile_attributes)

      patch admin_user_profile_path(somebodies(:first_user), Profile.last), request

      ['name', 'phone', 'email', 'passport', 'profile'].each do |profileable|

        instance_eval <<-CODE, __FILE__, __LINE__ + 1

          assert_equal 'update', #{profileable.camelize}Transaction.last.operation, "#{profileable}"
          assert_equal #{profileable.camelize}Transaction.last.creator_id, somebodies(:first_admin).id
          #assert_equal #{profileable.camelize}Transaction.last.somebody_id, somebodies(:first_user).id

          if profileable != 'profile'
            assert_equal #{profileable.camelize}Transaction.last.profile_id_after, Profile.last.id
            # TODO Кстати тут правильно по смыслу остался creation_reason 'frontend', т.к.
            # Наверно нужно написать похожий тест, только создание от лица администратора
            assert_equal 'frontend', assigns(:resource).#{profileable.pluralize}.first.creation_reason
          else
            assert_equal 'frontend', assigns(:resource).creation_reason
          end

        CODE
      end
    end

    # Проверяем доступность транзакции имен по нижеуказанным адресам
    #
    # ПОЛЬЗОВАТЕЛЬ собственные
    # Транзакции собственного имени от пользователя
    get user_name_transactions_path Name.last
    #
    # Транзакции всех собственных имен от пользователя
    get transactions_user_names_path

    #
    # Транзакции имени пользователя от администратора
    get admin_user_name_transactions_path somebodies(:first_user), Name.last

    # Транзакции всех имен пользователя от администратора
    get transactions_admin_user_names_path somebodies(:first_user)

    # Транзакции имен всех пользователей от администратора
    get transactions_admin_names_path


    authenticated_as '+7 (123) 123-12-31', '1231231231' do |sess|

      delete user_profile_path(Profile.last), { resource_class: 'Profile' }

      ['name', 'phone', 'email', 'passport', 'profile'].each do |profileable|
        instance_eval <<-CODE, __FILE__, __LINE__ + 1

          assert_equal 'destroy', #{profileable.camelize}Transaction.last.operation
          assert_equal #{profileable.camelize}Transaction.last.creator_id, somebodies(:first_user).id
          #assert_equal #{profileable.camelize}Transaction.last.somebody_id, somebodies(:first_user).id

        CODE
      end
    end
  end

end
