# encoding: utf-8
#
ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'capybara/rails'
require 'capybara/poltergeist'
require 'faye'

Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, {
    timeout: 20
    #debug: true
  })
end

Capybara.server do |app, port|
  Puma::Server.new(app).tap do |s|
    s.add_tcp_listener '127.0.0.1', port
  end.run.join
end

bayeux = Faye::RackAdapter.new(
  Rails.application,
  :mount => '/faye',
  :timeout => 25,
  :engine  => {
    :type  => Faye::Redis,
    :host  => SiteConfig.redis_address,
    :port  => SiteConfig.redis_port
  }
)

Capybara.app = bayeux


Capybara.server_port = 3000
Capybara.server_host = 'localhost'
#Capybara.default_driver = :selenium
Capybara.default_driver = :poltergeist
Capybara.javascript_driver = :poltergeist
Capybara.default_wait_time = 20


class ActionDispatch::IntegrationTest
  include Capybara::DSL

  private

  def auth(login, password, remember_me=false)
    visit '/login/phone'
    #assert page.has_css?('#login')
    fill_in 'session[value]', with: login
    fill_in 'session[password]', with: password
    check 'remember_me' if remember_me
    # debugger
    #find('type["submit"], text: 'Войти').click
    click_button 'Войти'
    #find('#submit').click
    #save_screenshot('1.png', full: true)
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

class ActiveRecord::Base
  mattr_accessor :shared_connection
  @@shared_connection = nil

  def self.connection
    @@shared_connection || retrieve_connection
  end
end
ActiveRecord::Base.shared_connection = ActiveRecord::Base.connection

  #test "Параллельные" do
  #  session1 = Capybara::Session.new Capybara.current_driver, Capybara.app
  #  session1.visit root_path

  #  session2 = Capybara::Session.new Capybara.current_driver, Capybara.app
  #  session2.visit root_path
  #end
