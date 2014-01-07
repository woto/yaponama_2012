# encoding: utf-8
#
ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'capybara/rails'
require 'capybara/poltergeist'

#Capybara.register_driver :poltergeist do |app|
#  Capybara::Poltergeist::Driver.new(app, {
#    timeout: 10,
#    #debug: true
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

Capybara.server_port = 3000
Capybara.server_host = 'localhost'
#Capybara.default_driver = :selenium
#Capybara.default_driver = :selenium
#Capybara.default_driver = :webkit
#Capybara.javascript_driver = :webkit
Capybara.default_driver = :poltergeist
Capybara.javascript_driver = :poltergeist
Capybara.default_wait_time = 20


class ActionDispatch::IntegrationTest
  include Capybara::DSL
  include ShowMeTheCookies

  private

  def fill_phone(id, login)
    assert has_css?(id)
    page.execute_script "$('" + id + "').val('#{login}')"
  end

  def fill_talk(text)
    assert has_css? '#cke_talk_talkable_attributes_chat_parts_attributes_0_chat_partable_attributes_text'
    sleep 1
    page.execute_script "CKEDITOR.instances.talk_talkable_attributes_chat_parts_attributes_0_chat_partable_attributes_text.setData('#{text}')"
  end

  def node &block
    # Мы сбрасываем кеш и обращаемся к чему-нибудь, чтобы заполнился SiteConfig
    #SiteConfig.class_variable_set(:@@cache, nil)
    #visit '/uploads/'

    #################
    #
    ##require 'rubygems'
    ##require 'ostruct'
    ##require 'open3'
    ##require 'debugger'

    ##Rails = OpenStruct.new
    ##Rails.env    = "development"
    ##Rails.root = '/home/woto/rails/yaponama_2012'

    #stdin, stdout, stderr, wait_thr = Open3.popen3({"RAILS_ENV" => Rails.env}, "coffee #{Rails.root}/realtime/realtime.coffee")
    #pid = wait_thr[:pid]  # pid of the started process.

    #begin puts line = stdout.gets.chomp
    #end while line != "READY"

    ##stdin.close  # stdin, stdout and stderr should be closed explicitly in this form.
    ##stdout.close
    ##stderr.close
    ##exit_status = wait_thr.value  # Process::Status object returned.
    #sleep 5

    #begin
    #  block.call
    #rescue Exception => e
    #  raise e
    #ensure
    #  Process.kill "HUP", pid
    #end
    #
    ################

    pid = Process.spawn({"RAILS_ENV" => Rails.env}, "coffee #{Rails.root}/realtime/realtime.coffee")

    # Detach the spawned process
    Process.detach pid

    sleep 5

    begin
      block.call
    rescue Exception => e
      raise e
    ensure
      Process.kill "HUP", pid
    end

  end

  def auth(login, password, remember_me=false)
    visit '/login/phone'
    fill_phone '#session_value', login
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
