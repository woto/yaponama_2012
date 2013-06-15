ShtRails.configure do |config|
  config.template_extension = 'handlebars' # change extension of mustache templates
  config.action_view_key    = 'handlebars' # change name of key for rendering in ActionView mustache template
  config.template_namespace = 'SHT'      # change templates namespace in javascript
  config.template_base_path = Rails.root.join("app", "templates") # templates dir
end
