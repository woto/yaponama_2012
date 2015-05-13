Ckpages.enabled = Rails.application.config_for('application/ckpages')['enabled']
Ckpages.root = Rails.application.config_for('application/ckpages')['root']


Ckpages::Engine.configure do |config|
  config.middleware.use Rack::Auth::Basic do |username, password|
    username == 'woto' && password == 'woto'
  end
end
