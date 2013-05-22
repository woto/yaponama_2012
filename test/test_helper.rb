# encoding: utf-8

ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'capybara/rails'

Capybara.server_port = 3000
Capybara.server_host = 'localhost'

class ActionDispatch::IntegrationTest
  include Capybara::DSL
end

class ActiveSupport::TestCase
  ActiveRecord::Migration.check_pending!

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...

  private

  def authenticated_as(login, password)
    open_session do |sess|
      post '/login', { :login => login, :password => password }
      follow_redirect!
      assert flash[:notice] = "Вы успешно вошли."
      yield sess if block_given?
      delete '/logout'
      follow_redirect!
    end
  end

  def auth(login, password)
    Capybara.current_driver = :selenium

    visit '/login'
    fill_in 'login', with: login
    fill_in 'password', with: password
    find('#submit').click
  end

end
