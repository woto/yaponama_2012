Ckpages.enabled = Rails.configuration.ckpages['enabled']
Ckpages.root = Rails.configuration.ckpages['root']


Ckpages::Engine.configure do |config|
  config.middleware.use Rack::Auth::Basic do |username, password|
    username == Rails.application.secrets.ckpages_username && password == Rails.application.secrets.ckpages_password
  end
end
