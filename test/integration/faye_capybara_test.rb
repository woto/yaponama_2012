# encoding: utf-8
#
require 'test_helper'

class VisitTest < ActionDispatch::IntegrationTest

  test 'Visiting root page with Capybara shoud not raise error' do
    Capybara.reset!

    first = Capybara::Session.new Capybara.current_driver, Capybara.app

    first.visit '/'

    sleep 0.5

    first.execute_script <<-"EOL"

    window.Application || (window.Application = {});

    Application.client.subscribe('/messages', function(message) {
      $('body').html('Got a message: ' + message.text)
    });

    EOL

    second = Capybara::Session.new Capybara.current_driver, Capybara.app

    second.visit 'http://localhost:3000'

    sleep 0.5

    second.execute_script <<-"EOL"

    window.Application || (window.Application = {});

    Application.client.publish('/messages', {
      text: 'Hello world'
    });

    EOL

    assert first.has_text?('Got a message: Hello world')

  end
end
