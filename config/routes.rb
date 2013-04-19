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
          post 'order_select'
        end
      end
    end
  end

  namespace :admin do

    concerns :profileable

    resources :users do

      concerns :productable

      get 'index'
      get 'edit'
      get '', action: 'show', :as => 'show'
      patch '', action: 'update'

      concerns :profileable

      resources :products do
        concerns :transactionable
        concerns :filterable
        collection do
          get 'status/:status' => "products#index"
          delete 'multiple_destroy' => "products#multiple_destroy"
        end
      end

      resources :orders do
        concerns :productable

        resources :products do
          concerns :transactionable
          concerns :filterable
          collection do 
            get 'status/:status' => "products#index"
            delete 'multiple_destroy' => "products#multiple_destroy"
          end
        end
        concerns :filterable
        concerns :transactionable
      end

      resource :cashes # /admin/users/X/cashes
      resource :discount # /admin/users/X/discount/edit
      resource :prepayment # /uadmin/users/X/prepayment/edit
    end

    concerns :productable

    namespace 'products' do
      get 'transactions'
    end

    resources :products do
      concerns :transactionable
      concerns :filterable
      collection do
        get 'status/:status' => "products#index"
        delete 'multiple_destroy' => "products#multiple_destroy"
      end

    end
    resources :spare_infos

    resources :orders do
      resources :products do
        concerns :transactionable
        concerns :filterable
      end
    end

  end

  resources :spare_infos

  resource :user  do
    concerns :productable

    resources :products do
      collection do
        get 'status/:status' => "products#index"
        delete 'multiple_destroy' => "products#multiple_destroy"
      end
      concerns :filterable
      concerns :transactionable
    end

    resources :orders do
      concerns :productable
      resources :products do
        concerns :filterable
        concerns :transactionable
        collection do
          get 'status/:status' => "products#index"
          delete 'multiple_destroy' => "products#multiple_destroy"
        end
      end
      concerns :transactionable
    end

    concerns :profileable
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

      resources :account_transactions # admin/users/X/money_trasactions

      collection do
        post 'filter' => "users#index"
      end

    end

    resources :products do
      concerns :transactionable
      collection do
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
    resources :account_transactions # admin/money_transactions

    resources :suppliers do
      resources :account_transactions # admin/suppliers/X/money_transactions
      resources :products do
        concerns :transactionable
      end
    end

    # ПОСЛЕ ЭТОЙ СТРОКИ ИДУТ НЕ ПОВТОРЯЮЩИЕСЯ МАРШРУТЫ ТОЛЬКО В АДМИНИСТРАТИВНОЙ ЧАСТИ САЙТА
    resources :metro
    resources :shops
    resources :delivery_categories
    resources :deliveries
    resources :site_settings
  end

  resources :account_transactions # /money_transactions

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

  get "*brand" => "brands#index", :constraints => BrandConstraint.new
  get "*path" => "pages#index", :constraints => PageConstraint.new

end
