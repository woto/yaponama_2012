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

  concern :profileable do
    resources :names, :controller => "profileables", :resource_class => 'Name' do
      post :toggle, :on => :member
    end
    resources :phones, :controller => "profileables", :resource_class => 'Phone' do
      post :toggle, :on => :member
    end
    resources :email_addresses, :controller => "profileables", :resource_class => 'EmailAddress' do
      post :toggle, :on => :member
    end
    resources :postal_addresses, :controller => "profileables", :resource_class => 'PostalAddress' do
      post :toggle, :on => :member
    end
    resources :cars, :controller => "profileables", :resource_class => 'Car' do
      post :toggle, :on => :member
    end
    resources :companies, :controller => "profileables", :resource_class => 'Company' do
      post :toggle, :on => :member
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
          post 'order_select'
        end
      end
    end
  end

  namespace :admin do

    resources :users do
      get 'index'
      get 'edit'
      get '', action: 'show'
      patch '', action: 'update'

      concerns :profileable
      resources :product_transactions
      resources :products
      resources :orders do
        resources :products
      end

      resource :cashes # /admin/users/X/cashes
      resource :discount # /admin/users/X/discount/edit
      resource :prepayment # /uadmin/users/X/prepayment/edit
    end

    concerns :productable

    resources :products do
      resources :product_transactions
    end
    resources :product_transactions
    resources :spare_infos

    resources :orders do
      resources :products
    end

  end

  concerns :productable

  resources :products do
    resources :product_transactions
  end

  resources :product_transactions
  resources :spare_infos

  resource :user  do
    concerns :profileable
  end

  resources :orders do
    resources :products
  end


  # .../admin/XXX
  namespace :admin do

    resources :users do
      concerns :parts_searchable
    end

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

    get 'users' => 'users#index', :as => 'root'

    #resources :sessions

    resources :companies

    resources :users do

      resources :money_transactions # admin/users/X/money_trasactions

      collection do
        post 'filter' => "users#index"
      end

    end

    resources :products do
      collection do
        post 'remember'
        delete 'multiple_destroy' => "products#multiple_destroy"
      end
      
    end

    resources :email_addresses

    resources :emails do
      member do
        get 'show_body'
        get 'show_text_part'
        get 'show_html_part'
        get 'show_html_part_sanitized'
      end
    end

    resources :accounts
    resources :money_transactions # admin/money_transactions

    resources :suppliers do
      resources :product_transactions
      resources :money_transactions # admin/suppliers/X/money_transactions
    end

    # ПОСЛЕ ЭТОЙ СТРОКИ ИДУТ НЕ ПОВТОРЯЮЩИЕСЯ МАРШРУТЫ ТОЛЬКО В АДМИНИСТРАТИВНОЙ ЧАСТИ САЙТА
    resources :metro
    resources :delivery_categories
    resources :deliveries
    resources :site_settings
  end

  resources :money_transactions # /money_transactions

  resources :talks do
    collection do
      get 'item'
    end
  end


  concerns :parts_searchable

  resources :calls

  resources :comments

  resources :uploads

  resources :pages

  resources :password_resets
  # resource :user

  #get "build/show"
  #get "build/update"
  #get "build/create"

  get 'trash_help/notify_sms'
  get 'trash_help/index'
  post 'trash_help/merge'
  post 'trash_help/make_payment'
  namespace 'trash_help' do
    post 'check_orders_inorder'
  end
  post 'trash_help/make_payment_to_supplier'

  resources :attachments

  get 'clear_session' => "trash_help#clear_session"

  get 'admin' => 'admin/users#index'

  root :to => 'welcome#index'

  # STATS
  resources :stats

  # ПОСЛЕ ЭТОЙ СТРОКИ ИДУТ НЕ ПОВТОРЯЮЩИЕСЯ ТОЛЬКО В ПУБЛИЧНОЙ ВЕРСИИ САЙТА .../XXX

  resources :password_resets

  # REGISTER
  resource :register do

    collection do
      get :email, :to => 'registers#edit', :with => 'email'
      patch :email, :to => 'registers#update', :as => 'email', :with => 'email'
    end

    collection do
      get :sms, :to => 'registers#edit', :with => 'sms'
      patch :sms, :to => 'registers#update', :as => 'sms', :with => 'sms'
    end

    collection do
      get :call, :to => 'registers#edit', :with => 'call'
      patch :call, :to => 'registers#update', :as => 'call', :with => 'call'
    end

    collection do
      get :social, :to => 'registers#edit', :with => 'social'
      patch :social, :to => 'registers#update', :as => 'call', :with => 'social'
    end

  end

  # LOGIN / LOGOUT
  get 'login' => 'sessions#new', :as => 'login'
  post 'login' => 'sessions#create', :as => 'login'
  delete 'logout' => 'sessions#destroy', :as => 'logout'

  # OMNIAUTH
  get '/auth/:provider/callback' => 'auth#create'
  get '/auth/failure' => 'auth#failure'

  # ROBOTS.TXT
  get 'robots.txt' => "robots_txt#index"

  get "*brand" => "brands#index", :constraints => BrandConstraint.new
  get "*path" => "pages#index", :constraints => PageConstraint.new

end
