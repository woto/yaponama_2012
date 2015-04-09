$discourse = DiscourseApi::Client.new('http://' + Rails.application.config_for('application/discourse')['host_port'])
$discourse.api_username = Rails.application.config_for('application/discourse')['api_username']
$discourse.api_key = Rails.application.config_for('application/discourse')['api_key']

