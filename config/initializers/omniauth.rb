#OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer unless Rails.env.production?

  provider :google_oauth2, SiteConfig.google_oauth2_key, SiteConfig.google_oauth2_secret, {:access_type => 'online', :approval_prompt => ''}
  provider :facebook, SiteConfig.facebook_key, SiteConfig.facebook_secret
  provider :vkontakte, SiteConfig.vkontakte_key, SiteConfig.vkontakte_secret
  provider :twitter, SiteConfig.twitter_key, SiteConfig.twitter_secret
  provider :yandex, SiteConfig.yandex_key, SiteConfig.yandex_secret
  provider :odnoklassniki, SiteConfig.odnoklassniki_key, SiteConfig.odnoklassniki_secret
  provider :mailru, SiteConfig.mailru_key, SiteConfig.mailru_secret
end

#if Rails.env.test?
#  OmniAuth.config.test_mode = true
#
#  OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
#    :provider => 'google_oauth2',
#    :uid => '123545'
#  })
#
#end
