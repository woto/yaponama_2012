class BrandConstraint
  def initialize
    #@ips = Blacklist.retrieve_ips
    #@brand_names = Brand.pluck(:name)
  end

  def matches?(request)
    #@ips.include?(request.remote_ip)
    @brand_names = Brand.pluck(:name)
    @brand_names.include? request.params[:brand]
  end
end

class PageConstraint
  def matches?(request)
    @page = Page.where(:path => request.params[:path])
    @page.present?
  end
end

Yaponama2012::Application.routes.draw do

  resources :calls

  concern :filterable do
    match 'filter', :via => [:get, :post], :on => :collection
    match 'filter', :via => [:get, :post]
  end

  concern :transactionable do
    get 'transactions', :on => :collection
    get 'transactions', :on => :member
    get 'transactions'
  end

  concern :profileable do
    resources :names, :controller => "profileables", :resource_class => 'Name' do
      concerns :transactionable
      concerns :filterable
    end
    resources :phones, :controller => "profileables", :resource_class => 'Phone' do
      concerns :transactionable
      concerns :filterable
    end
    resources :email_addresses, :controller => "profileables", :resource_class => 'EmailAddress' do
      concerns :transactionable
      concerns :filterable
    end
    resources :postal_addresses, :controller => "profileables", :resource_class => 'PostalAddress' do
      concerns :transactionable
      concerns :filterable
    end
    resources :cars, :controller => "profileables", :resource_class => 'Car' do
      concerns :transactionable
      concerns :filterable
    end
    resources :companies, :controller => "profileables", :resource_class => 'Company' do
      concerns :transactionable
      concerns :filterable
    end
  end


  concern :parts_searchable do
    resources :searches do
      match '(/:catalog_number(/:manufacturer(/:replacements)))' => "searches#index", :on => :collection, :as => 'search', :via => :get
      match '?skip' => "searches#index", :on => :collection, :as => :skip_search, :via => :get
    end
  end

  concern :productable do
    namespace :products do
      resources :edit
      resources :incart
      resources :ordered
      resources :cancel
      resources :pre_supplier
      resources :post_supplier
      resources :stock
      resources :complete
      resources :return
      resources :split
      resources :inorder do
        member do
          get 'action'
          post 'action'
        end
        collection do
          get 'action'
          post 'action'
        end
        collection do
          post 'order_select'
          get 'order_select'
        end
      end
    end
  end

  concern :complex_products do
    resources :products do
      concerns :transactionable
      concerns :filterable
      collection do
        get 'status/:status' => "products#index", :as => :status
        delete 'multiple_destroy' => "products#multiple_destroy"
      end
    end
  end

  concern :complex_orders do
    resources :orders do
      collection do
        get 'status/:status' => "orders#index", :as => :status
      end
      concerns :filterable
      concerns :transactionable
      concerns :productable

      concerns :complex_products
    end
  end

  namespace :admin do

    resources :calls

    resources :stats do
      get "iframe", :on => :member
    end

    resources :blocks

    concern :searchable do
      get 'search', :on => :collection
    end

    resources :models, :generations, :modifications, :brands, concerns: :searchable


    resources :uploads

    get 'pages/new/:path' => "pages#new", :as => 'new_predefined_page', :constraints => {:path => /.*/}
    resources :pages

    resources :accounts

    # ПОСЛЕ ЭТОЙ СТРОКИ ИДУТ НЕ ПОВТОРЯЮЩИЕСЯ МАРШРУТЫ ТОЛЬКО В АДМИНИСТРАТИВНОЙ ЧАСТИ САЙТА
    resources :metro
    resources :shops
    resources :delivery_categories
    resources :deliveries
    resources :site_settings

    resources :suppliers do
      resources :account_transactions # admin/suppliers/X/money_transactions
      resources :products do
        concerns :transactionable
      end
    end

    resources :account_transactions # admin/money_transactions

    concerns :profileable
    concerns :productable
    concerns :complex_products
    concerns :complex_orders

    resources :spare_infos


    resources :users do

      get 'index'
      get 'edit'
      get '', action: 'show', :as => 'show'
      patch '', action: 'update'


      concerns :parts_searchable
      resources :account_transactions # admin/users/X/money_trasactions

      concerns :profileable
      concerns :productable
      concerns :complex_products
      concerns :complex_orders

      resource :cashes, :only => [:new, :create]
      resource :discount, :only => [:edit, :update]
      resource :prepayment, :only => [:edit, :update]
    end


    # СОМНИТЕЛЬНЫЕ МАРШРУТЫ
    resources :emails do
      member do
        get 'show_body'
        get 'show_text_part'
        get 'show_html_part'
        get 'show_html_part_sanitized'
      end
    end


  end

  resources :spare_infos

  resource :user  do
    concerns :profileable
    concerns :productable
    concerns :complex_products
    concerns :complex_orders
  end

  resources :talks do
    collection do
      get 'item'
    end
  end


  concerns :parts_searchable
  resources :account_transactions

  resources :comments
  resources :uploads


  resources :password_resets, :only => [:new, :create, :edit, :update]

  resources :attachments


  get 'admin' => 'admin/users#index'

  root :to => 'welcome#index'


  # REGISTER
  resource :register, :only => [:show, :edit, :update] do

    collection do
      get :email, :to => 'registers#edit', :with => 'email'
      patch :email, :to => 'registers#update', :with => 'email'
    end

    collection do
      get :sms, :to => 'registers#edit', :with => 'sms'
      patch :sms, :to => 'registers#update', :with => 'sms'
    end

    collection do
      get :call, :to => 'registers#edit', :with => 'call'
      patch :call, :to => 'registers#update', :with => 'call'
    end

    collection do
      get :social, :to => 'registers#edit', :with => 'social'
      patch :social, :to => 'registers#update', :with => 'social'
    end

  end

  # LOGIN / LOGOUT
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy', :as => 'logout'

  # OMNIAUTH
  get '/auth/:provider/callback' => 'auth#create'
  get '/auth/failure' => 'auth#failure'

  # ROBOTS.TXT
  get 'robots.txt' => "robots_txt#index"

  # STATS
  resources :stats, :only => [:create]


  # СОМНИТЕЛЬНЫЕ МАРШРУТЫ
  get 'trash_help/notify_sms'
  get 'trash_help/index'
  post 'trash_help/merge'
  post 'trash_help/make_payment'
  namespace 'trash_help' do
    post 'check_orders_inorder'
  end
  post 'trash_help/make_payment_to_supplier'
  get 'clear_session' => "trash_help#clear_session"


  get "*brand" => "brands#index", :constraints => BrandConstraint.new
  get "*path" => "pages#show", :constraints => PageConstraint.new

end
