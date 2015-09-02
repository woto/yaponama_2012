$discourse = DiscourseApi::Client.new('http://' + Rails.configuration.discourse['host_port'])
$discourse.api_username = Rails.configuration.discourse['api_username']
$discourse.api_key = Rails.configuration.discourse['api_key']
