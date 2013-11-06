# encoding: utf-8
#
require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Assets should be precompiled for production (so we don't need the gems loaded then)
Bundler.require(*Rails.groups(assets: %w(development test)))

module Yaponama2012
  class Application < Rails::Application
    
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Custom directories with classes and modules you want to be autoloadable.
    config.autoload_paths += %W(#{config.root}/extras)
    config.autoload_paths += %W(#{config.root}/delivery)


    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'UTC'


    # Offset Russian Time Zones in UTC
    config.russian_time_zones = {
      "3"  => 'Калининградское время', 
      "4"  => 'Московское время', 
      "6"  => 'Екатеринбургское время', 
      "7"  => 'Омское время', 
      "8"  => 'Красноярское время',
      "9"  => 'Иркутское время', 
      "10" => 'Якутское время', 
      "11" => 'Владивостокское время', 
      "12" => 'Магаданское время',
    }
    
    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]
    config.i18n.default_locale = :ru

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

    config.less.paths += [
      File.join(config.root, 'system', 'submodules')
      #File.join(config.root, 'vendor', 'assets', 'bootstrap', 'less'),
      #File.join(config.root, 'vendor', 'assets', 'bootstrap', 'less'),
    ]

    # Дополнительная директория для библиотек, которые несут в себе всё вместе
    config.assets.paths += [
      File.join(config.root, 'vendor', 'assets', 'libraries'),
      File.join(config.root, 'app', 'assets', 'classes'),
      File.join(config.root, 'app', 'assets', 'templates'),
      File.join(config.root, 'app', 'assets', 'sounds'),
    ]

    # Autoload ckeditor models folder
    # config.autoload_paths += %W(#{config.root}/app/models/ckeditor)
    #

    config.somebody_creation_reason = { 
      'session' => 'Посетил сайт',
      'order' => 'В процессе оформления заказа',
      'email' => 'Прислал e-mail',
      'chat' => 'Сообщение чата',
      'seed' => 'Первичная загрузка',
      'fixtures' => 'Тестовые данные',
      'register' => 'Регистрация',
      'backend' => 'Менеджер',
      'phone_number' => 'Регистрация с пом. тел. номера',
      'email_address' => 'Регистрация с пом. эл. почты',
      'merge' => 'Образовался в результате объединения',
      'call' => 'Звонок',
    }

    config.supplier_creation_reason = config.somebody_creation_reason
    config.user_creation_reason = config.somebody_creation_reason

    config.product_creation_reason = {
      'fixtures' => 'Тестовые данные',
      'backend' => 'Бэкэнд',
      'frontend' => 'Фронтэнд'
    }


    # Phones
    config.phone_creation_reason = {
      'session' => 'Посетил сайт',
      'order' => 'В процессе оформления заказа',
      'email' => 'Прислал e-mail',
      'chat' => 'Сообщение чата',
      'seed' => 'Первичная загрузка',
      'fixtures' => 'Тестовые данные',
      'register' => 'Регистрация',
      'backend' => 'Менеджер',
      'phone_number' => 'Регистрация с пом. тел. номера',
      'addressee' => 'В процессе оформления заказа (Контактный телефон)',
      'callback' => 'Заказал обратный вызов',
      'backend' => 'Заполнение профиля',
      'frontend' => 'Заполнение профиля',
      'call' => 'Звонок',
    }

    # Names
    config.name_creation_reason = {
      'session' => 'Посетил сайт',
      'order' => 'В процессе оформления заказа',
      'email' => 'Прислал e-mail',
      'chat' => 'Сообщение чата',
      'seed' => 'Первичная загрузка',
      'fixtures' => 'Тестовые данные',
      'register' => 'Регистрация',
      'backend' => 'Менеджер',
      'comment' => 'Комментарий',
      'phone_number' => 'Регистрация с пом. тел. номера',
      'email_address' => 'Регистрация с пом. эл. почты',
      'addressee' => 'В процессе оформления заказа (получатель)',
      'self' => 'Представился на сайте',
      'google_oauth2' => 'Google',
      'facebook' => 'Facebook',
      'twitter' => 'Twitter',
      'yandex' => 'Yandex',
      'vkontakte' => 'Вконтакте',
      'odnoklassniki' => 'Одноклассники',
      'mailru' => 'Mail.ru',
      'backend' => 'Заполнение профиля',
      'frontend' => 'Заполнение профиля',
      'call' => 'Звонок',
    }

    # Emails
    config.email_creation_reason = {
      'session' => 'Посетил сайт',
      'order' => 'В процессе оформления заказа',
      'email' => 'Прислал e-mail',
      'chat' => 'Сообщение чата',
      'seed' => 'Первичная загрузка',
      'fixtures' => 'Тестовые данные',
      'register' => 'Регистрация',
      'backend' => 'Менеджер',
      'email_address' => 'Регистрация с пом. эл. почты',
      'backend' => 'Заполнение профиля',
      'frontend' => 'Заполнение профиля',
      'call' => 'Звонок',
    }

    config.postal_address_creation_reason = {
      'order' => 'В процессе оформления заказа',
      'email' => 'Прислал e-mail',
      'chat' => 'Сообщение чата',
      'seed' => 'Первичная загрузка',
      'fixtures' => 'Тестовые данные',
      'backend' => 'Менеджер',
      'company' => 'Ввод компании',
      'backend' => 'Заполнение профиля',
      'frontend' => 'Заполнение профиля',
    }

    config.car_creation_reason = {
      'order' => 'В процессе оформления заказа',
      'email' => 'Прислал e-mail',
      'chat' => 'Сообщение чата',
      'seed' => 'Первичная загрузка',
      'fixtures' => 'Тестовые данные',
      'backend' => 'Менеджер',
      'backend' => 'Заполнение профиля',
      'frontend' => 'Заполнение профиля',
    }

    config.company_creation_reason = {
      'order' => 'В процессе оформления заказа',
      'email' => 'Прислал e-mail',
      'chat' => 'Сообщение чата',
      'seed' => 'Первичная загрузка',
      'fixtures' => 'Тестовые данные',
      'backend' => 'Менеджер',
      'backend' => 'Заполнение профиля',
      'frontend' => 'Заполнение профиля',
    }


    config.order_creation_reason = {
      'order' => 'В процессе оформления заказа',
      'email' => 'Прислал e-mail',
      'chat' => 'Сообщение чата',
      'seed' => 'Первичная загрузка',
      'fixtures' => 'Тестовые данные',
      'backend' => 'Менеджер',
    }

    config.profile_creation_reason = {
      'order' => 'В процессе оформления заказа',
      'email' => 'Прислал e-mail',
      'chat' => 'Сообщение чата',
      'seed' => 'Первичная загрузка',
      'fixtures' => 'Тестовые данные',
      'register' => 'Регистрация',
      'backend' => 'Менеджер',
      'backend' => 'Заполнение профиля',
      'frontend' => 'Заполнение профиля',
      'call' => 'Звонок',
      'session' => 'Посетил сайт',
    }

    config.passport_creation_reason = {
      'session' => 'Посетил сайт',
      'order' => 'В процессе оформления заказа',
      'email' => 'Прислал e-mail',
      'chat' => 'Сообщение чата',
      'seed' => 'Первичная загрузка',
      'fixtures' => 'Тестовые данные',
      'backend' => 'Менеджер',
      'backend' => 'Заполнение профиля',
      'frontend' => 'Заполнение профиля',
    }

    config.talk_creation_reason = {
      'email' => 'Прислал e-mail',
      'chat' => 'Сообщение чата'
    }

    config.page_creation_reason = {
      'backend' => 'Бэкенд'
    }

    config.upload_creation_reason = {
      'frontend' => 'Фронтенд',
      'backend' => 'Бэкенд'
    }

    # Orders
    config.orders_status = {
      'all' => {
        'real' => false,
        'title' => "Все",
        'hint' => "Все заказы, находящиеся в разных статусах."
      },
      'open' => {
        'real' => true,
        'title' => 'Открыт',
        'hint' => 'В заказ возможно добавление товаров.'
      },
      'close' => {
        'real' => true,
        'title' => 'Закрыт',
        'hint' => 'Все товары заказа выданы или отправлены. Добавление товаров в заказ невозможно.'
      }
    }

    # Products
    config.products_status = {
      'all' => {
        'real' => false,
        'title' => "Все",
        'hint' => "Все товары, находящиеся в разных статусах.",
        'badge' => ''
      },
      'active' => {
        'real' => false,
        'title' => 'Активн.',
        'hint' => 'Товары по которым необходима дальнейшая работа и фигурируют деньги.',
        'badge' => ''
      },
      'incart' => {
        'real' => true,
        'title' => 'В корз.',
        'action' => 'Переместить в корзину',
        'hint' => 'Товар находится в корзине клиента. Необходимо подтолкнуть клиента к заказу.',
        'badge' => '1'
      },
      'inorder' => { 
        'real' => true,
        'title' => 'Оформ.',
        'action' => 'Сформировать в заказ покупателя',
        'hint' => 'Товар в заказе, но не запущен в работу по причине правила предоплаты. (Выражен в процентах от 0% до 100%).',
        'badge' => '2'
      },
      'ordered' => {
        'real' => true,
        'title' => 'Оплач.',
        'action' => 'Отметить как оплаченный',
        'hint' => 'Заказ запущен, необходимый процент (от 0% до 100%) от суммы товаров заблокирован.',
        'badge' => '3'
      },
      'pre_supplier' => {
        'real' => true,
        'title' => "В раб.",
        'action' => 'Заблокировать отмену статуса оплаты',
        'hint' => "Необходимо отправить в заказ поставщику. Отказ клиента по этим товарам уже невозможен.",
        'badge' => '4'
      },
      'post_supplier' => {
        'real' => true,
        'title' => "Выкуп.",
        'action' => 'Отметить как заказанный у поставщика',
        'hint' => "Товар заказан у поставщика, ожидается поступление.",
        'badge' => '5'
      },
      'stock' => {
        'real' => true,
        'title' => "На скл.",
        'action' => 'Получен от поставщика',
        'hint' => "Товар получен от поставщика.",
        'badge' => '6'
      },
      'complete' => {
        'real' => true,
        'title' => "Выдан",
        'action' => "Выдать клиенту",
        'hint' => "Товар выдан клиенту.",
        'badge' => ''
      },
      'cancel' => {
        'real' => true,
        'title' => "Отказ",
        'action' => 'Отказать покупателю',
        'hint' => "Отказ по товару по причине брака, утери, прочей невозможности осуществления реализации. А так же отказ покупателя, отказ поставщика, возврат.",
        'badge' => ''
      }
    }

    config.sanitize_config = {
      :elements => %w[
        a abbr b bdo blockquote br caption cite code col colgroup dd del dfn dl
        dt em figcaption figure h1 h2 h3 h4 h5 h6 hgroup i img ins kbd li mark
        ol p pre q rp rt ruby s samp small strike strong sub sup table tbody td
        tfoot th thead time tr u ul var wbr span div font center
      ],

      :attributes => {
        :all         => ['dir', 'lang', 'title', 'align', 'class'],
        'a'          => ['href', 'target'],
        'blockquote' => ['cite'],
        'col'        => ['span', 'width'],
        'colgroup'   => ['span', 'width'],
        'del'        => ['cite', 'datetime'],
        'img'        => ['alt', 'height', 'src', 'width', 'vspace', 'hspace'],
        'ins'        => ['cite', 'datetime'],
        'ol'         => ['start', 'reversed', 'type'],
        'q'          => ['cite'],
        'table'      => ['summary', 'width', 'height', 'background', 'cellpadding', 'cellspacing', 'border', 'bgcolor'],
        'td'         => ['abbr', 'axis', 'colspan', 'rowspan', 'width', 'height', 'bgcolor', 'valign', 'background'],
        'tr'         => ['height'],
        'th'         => ['abbr', 'axis', 'colspan', 'rowspan', 'scope', 'width'],
        'time'       => ['datetime', 'pubdate'],
        'ul'         => ['type'],
        'font'       => ['face', 'size', 'color']
      },

      :protocols => {
        'table'      => {'background' => ['http', 'https', :relative]},
        'td'         => {'background' => ['http', 'https', :relative]},
        'a'          => {'href' => ['ftp', 'http', 'https', 'mailto', :relative]},
        'blockquote' => {'cite' => ['http', 'https', :relative]},
        'del'        => {'cite' => ['http', 'https', :relative]},
        'img'        => {'src'  => ['http', 'https', :relative]},
        'ins'        => {'cite' => ['http', 'https', :relative]},
        'q'          => {'cite' => ['http', 'https', :relative]}
      }
    }

    config.action_mailer.delivery_method = :smtp

    config.action_mailer.smtp_settings = {
      address:                 "127.0.0.1",
      port:                    25,
      enable_starttls_auto:    true
    }

    # User Order Rule
    config.somebody_order_rules = {
      'all' => 'Хватает на все товары',
      'none' => 'Отправлять вручную',
    }
    config.robokassa_integration_modes = {
      'production' => 'Рабочий режим',
      'test' => 'Тестовый режим'
    }


    config.company_ownerships = {
      'individual' => 'Индивидуальный предприниматель',
      'legal' => 'Юридическое лицо'
    }

    config.genders = {
      'male' => 'Мужской', 
      'female' => 'Женский'
    }

    config.vin_or_frame = {
      'vin' => 'VIN код',
      'frame' => 'Frame код'
    }

    config.default_somebody_role = 'guest'

    ## Default settings for new users
    #config.default_user_attributes = {
    #  'prepayment_percent' => 20,
    #  'discount' => 0,
    #  'order_rule' => 'all',
    #  'role' => 'guest'
    #}
    config.somebody_roles = {
      'all' => {
        'password_required' => false,
        'real' => false,
        'title' => 'Все',
        'title_plural' => 'Все',
        'privileged' => false
      },
      'admin' => {
        'password_required' => true,
        'real' => true,
        'title' => 'Администратор',
        'title_plural' => 'Администраторы',
        'privileged' => true
      },
      'manager' => {
        'password_required' => true,
        'real' => true,
        'title' => 'Менеджер',
        'title_plural' => 'Менеджеры',
        'privileged' => true
      },
      'user' => {
        'password_required' => true,
        'real' => true,
        'title' => 'Покупатель',
        'title_plural' => 'Покупатели',
        'privileged' => false
      },
      'guest' => {
        'password_required' => false,
        'real' => true,
        'title' => 'Гость',
        'title_plural' => 'Гости',
        'privileged' => false
      }
    }

    # Все роли
    config.somebody_roles_keys = config.somebody_roles
      .select{ |k, v| v["real"] == true }
      .keys

    # Роли, где требуется пароль
    config.somebody_roles_password_required_keys = config.somebody_roles
      .select{ |k, v| v["real"] == true }
      .select{ |k, v| v["password_required"] == true }
      .keys

    # Роли, где не требуется пароль
    config.somebody_roles_password_not_required_keys = config.somebody_roles
      .select{ |k, v| v["real"] == true }
      .select{ |k, v| v["password_required"] == false }
      .keys


    # Привилeгированные 
    config.somebody_roles_privileged_keys = config.somebody_roles
      .select{ |k, v| v["real"] == true }
      .select{ |k, v| v["privileged"] == true }
      .keys

    # Не привилeгированные 
    config.somebody_roles_not_privileged_keys = config.somebody_roles
      .select{ |k, v| v["real"] == true }
      .select{ |k, v| v["privileged"] == false }
      .keys



    #config.avisosms = {
    #  username: 'username',
    #  password: 'password',
    #  # Доступные варианты: flash sms growl
    #  method: 'flash',
    #  source_address: 'Yaponama',
    #  delivery_report: '1',
    #  flash_message: '0',
    #  validity_period: '10'
    #}

    config.sms_notify_methods = %w(flash sms growl)

    config.action_view.field_error_proc = Proc.new { |html_tag, instance| 
      "#{html_tag}".html_safe 
    }

  end
end
