$discourse = DiscourseApi::Client.new(Rails.application.config_for('application/discourse')['url'])
$discourse.api_username = Rails.application.config_for('application/discourse')['api_username']
$discourse.api_key = Rails.application.config_for('application/discourse')['api_key']

