# encoding: utf-8

ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'capybara/rails'
require 'capybara/poltergeist'


#Capybara.register_driver :poltergeist do |app|
#  Capybara::Poltergeist::Driver.new(app, {
#    timeout: 120
#  })
#end

Capybara.server_port = 3000
Capybara.server_host = 'localhost'
#Capybara.default_driver = :selenium
Capybara.default_driver = :poltergeist
Capybara.javascript_driver = :poltergeist
#Capybara.default_wait_time = 10


class ActionDispatch::IntegrationTest
  include Capybara::DSL

  private

  def auth(login, password)

    visit '/login'
    #assert page.has_css?('#login')
    fill_in 'login', with: login
    fill_in 'password', with: password
    find('#submit').click
    #assert page.has_css? ".alert-success", text: "Вы успешно вошли."
  end

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

end
