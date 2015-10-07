ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'capybara/rails'
require 'capybara/poltergeist'
require 'capybara/dsl'
require "minitest/autorun"

#Capybara.register_driver :poltergeist do |app|
#  Capybara::Poltergeist::Driver.new(app, {
#    timeout: 10,
#    debug: true
#  })
#end

#Capybara.register_driver :selenium do |app|
#  Capybara::Selenium::Driver.new(app, :browser => :chrome)
#end

#Capybara.register_driver :poltergeist do |app|
#  Capybara::Poltergeist::Driver.new(app, {
#    timeout: 10,
#    debug: true
#  })
#end

#Capybara.server do |app, port|
#  #require 'rack/handler/thin'
#  #Rack::Handler::Thin.run(app, :Port => port)
#
#  Puma::Server.new(app).tap do |s|
#    s.add_tcp_listener '127.0.0.1', port
#  end.run.join
#end

#Capybara.app_host
#Capybara.always_include_port
#Capybara.default_host
Capybara.server_port = 4000
Capybara.server_host = '127.0.0.1'
Capybara.default_driver = :selenium
Capybara.default_driver = :selenium
#Capybara.default_driver = :webkit
#Capybara.javascript_driver = :webkit
#Capybara.default_driver = :poltergeist
#Capybara.javascript_driver = :poltergeist
Capybara.default_wait_time = 5

#Selenium::WebDriver::Firefox::Binary.path="/home/woto/firefox/firefox"


class ActionDispatch::IntegrationTest
  include Warden::Test::Helpers
  Warden.test_mode!
  include Capybara::DSL
  include ShowMeTheCookies
end


class ActionController::TestCase
  include Devise::TestHelpers
  Warden.test_mode!
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
      post '/login/phone', { session: {value: login, password: password, mobile: true } }
      follow_redirect!
      assert flash[:notice] = "Вы успешно вошли."
      yield sess if block_given?
      delete '/logout'
      follow_redirect!
    end
  end

  def email_fixture(email)
    File.read(File.join(Rails.root, 'test', 'fixtures', 'receive_mailer', email))
  end

end

#class ActiveRecord::Base
#  mattr_accessor :shared_connection
#  @@shared_connection = nil
#
#  def self.connection
#    @@shared_connection || retrieve_connection
#  end
#end
#ActiveRecord::Base.shared_connection = ActiveRecord::Base.connection


#test "Параллельные" do
#  session1 = Capybara::Session.new Capybara.current_driver, Capybara.app
#  session1.visit root_path
#  session2 = Capybara::Session.new Capybara.current_driver, Capybara.app
#  session2.visit root_path
#end
