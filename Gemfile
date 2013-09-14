source 'https://rubygems.org'

#gem 'rails',     github: 'rails/rails'
gem 'rails',     path: '/home/woto/vendor/rails'
gem 'arel',      github: 'rails/arel'

gem 'pg'

gem 'json'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sprockets-rails', github: 'rails/sprockets-rails'
  gem 'sass-rails',   github: 'rails/sass-rails'
  gem 'coffee-rails', github: 'rails/coffee-rails'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyracer', platforms: :ruby

  gem 'uglifier', '>= 1.0.3'

end

group :production do
  gem 'puma'
end

group :development, :test do
  gem 'debugger'
  gem 'capistrano'
  gem 'capybara', github: 'jnicklas/capybara'
  #gem 'selenium-webdriver'
  gem 'poltergeist'
  #gem 'capybara-webkit'
  gem 'quiet_assets'
end

gem 'jquery-rails', github: 'rails/jquery-rails'
gem 'jquery-ui-rails', github: 'joliss/jquery-ui-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.0.1'
group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# To use ActiveModel has_secure_password
gem 'bcrypt-ruby', '~> 3.1.0'

gem 'less-rails'

gem 'simple_form', git: 'https://github.com/plataformatec/simple_form.git'
gem 'cocoon', :git => 'https://github.com/nathanvda/cocoon'
gem 'russian'
gem 'kaminari'
gem 'carrierwave'
gem 'rmagick'
gem 'sanitize'
gem 'slim-rails'
gem "cancan"
gem 'whenever'
gem 'sitemap_generator'
gem 'fastercsv'
gem 'yandex_mystem'
gem 'ipgeobase', :git => 'git://github.com/woto/ipgeobase.git'
gem 'activemerchant', :require => 'active_merchant', :git => 'https://github.com/Shopify/active_merchant', :ref => 'b14e285774e599697653325c471e1c85a7163d64'

#gem "hiredis", "~> 0.3.1"
#gem "redis", "~> 2.2.0", :require => ["redis/connection/hiredis", "redis"]
#gem 'juggernaut', :git => 'https://github.com/woto/juggernaut.git'

gem "redis", "~> 3.0.1"
gem "hiredis", "~> 0.4.5"

gem 'ruby-growl'
gem 'ancestry'
gem 'turbolinks'

# Mysql2 является обязательным требованием для SphinxQL
gem 'mysql2',          '0.3.12b4'
gem 'thinking-sphinx', '3.0.0'

gem 'charlock_holmes'

gem 'omniauth'
gem 'omniauth-google-oauth2'
gem 'omniauth-facebook'
gem 'omniauth-twitter'

gem 'omniauth-yandex'
gem 'omniauth-vkontakte'
gem 'omniauth-odnoklassniki'
gem 'omniauth-mailru'

gem 'sht_rails', github: 'railsware/sht_rails'

# Необходима версия 2.6.0 чтобы не резался многострочный заголовок
gem 'mail', github: 'mikel/mail'
