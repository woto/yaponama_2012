require File.expand_path('../boot', __FILE__)

ENV['RANSACK_FORM_BUILDER'] = '::SimpleForm::FormBuilder'

require 'rails/all'

# Assets should be precompiled for production (so we don't need the gems loaded then)
Bundler.require(*Rails.groups(assets: %w(development test)))

module Yaponama2012
  class Application < Rails::Application

    config.generators do |g|
      g.template_engine :erb
    end

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Custom directories with classes and modules you want to be autoloadable.
    config.autoload_paths += %W(
      #{config.root}/lib
      #{config.root}/app/workers
      #{config.root}/rake
      #{config.root}/catalog)

    #config.autoload_paths += %W(#{config.root}/delivery)


    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'UTC'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]

    config.i18n.enforce_available_locales = true
    config.i18n.default_locale = :ru
    config.i18n.locale = :ru

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"

    # Enable escaping HTML in JSON.
    config.active_support.escape_html_entities_in_json = true

    # Use SQL instead of Active Record's schema dumper when creating the database.
    # This is necessary if your schema can't be completely dumped by the schema dumper,
    # like if you have constraints or database-specific column types
    # config.active_record.schema_format = :sql

    # Enforce whitelist mode for mass assignment.
    # This will create an empty whitelist of attributes available for mass-assignment for all models
    # in your app. As such, your models will need to explicitly whitelist or blacklist accessible
    # parameters by using an attr_accessible or attr_protected declaration.
    # config.active_record.whitelist_attributes = true
 
    # Enable the asset pipeline
    config.assets.enabled = true

    config.action_view.field_error_proc = Proc.new { |html_tag, instance| 
      binding.pry
      "#{html_tag}".html_safe 
    }

    config.active_record.raise_in_transactional_callbacks = true

    Rails.application.configure do
      config.ckpages = config_for('application/ckpages')
      config.common = config_for('application/common')
      config.discourse = config_for('application/discourse')
      config.map = config_for('application/map')
      config.opts_accumulator = config_for('application/opts/accumulator')
      config.opts_truck_tire = config_for('application/opts/truck_tire')
      config.price = config_for('application/price')
      config.site = config_for('application/site')
    end


    config.action_mailer.default_url_options = {
      :host => config.site['host'],
      :port => config.site['port'],
      :protocol => :http }

  end
end
