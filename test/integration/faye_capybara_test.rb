# encoding: utf-8
#
require 'test_helper'

class VisitTest < ActionDispatch::IntegrationTest

  test 'Visiting root page with Capybara shoud not raise error' do

    visit '/'

    page.execute_script <<-"EOL"

    window.Application || (window.Application = {});

    Application.client.subscribe('/messages', function(message) {
      $('body').html('Got a message: ' + message.text)
    });

    EOL

    sleep 0.5

    page.execute_script <<-"EOL"

    window.Application || (window.Application = {});

    Application.client.publish('/messages', {
      text: 'Hello world'
    });

    EOL

    sleep 0.5

    assert has_text?('Got a message: Hello world')

  end
end
