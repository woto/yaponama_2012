#OmniAuth.config.logger = Rails.logger

#SERVICES = YAML.load(File.open("#{::Rails.root}/config/oauth.yml").read)

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer unless Rails.env.production?

  provider :google_oauth2, SiteConfig.google_oauth2_key, SiteConfig.google_oauth2_secret, {:access_type => 'online', :approval_prompt => ''} # if SERVICES['google']
  provider :facebook, SiteConfig.facebook_key, SiteConfig.facebook_secret
  provider :vkontakte, SiteConfig.vkontakte_key, SiteConfig.vkontakte_secret
  provider :twitter, SiteConfig.twitter_key, SiteConfig.twitter_secret
  provider :yandex, SiteConfig.yandex_key, SiteConfig.yandex_secret
  provider :odnoklassniki, SiteConfig.odnoklassniki_key, SiteConfig.odnoklassniki_secret
  provider :mailru, SiteConfig.mailru_key, SiteConfig.mailru_secret
end

