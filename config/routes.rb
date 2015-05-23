# TODO Удалить как поисковые роботы перестроятся
class BrandRedirector
  def matches?(request)
    Brand.find_by(name: CGI.unescape(request.params[:brand]))
  end
end


Yaponama2012::Application.routes.draw do

  resources :polls

  # /brands/дочерний_id/parts -> /brands/родительский_id
  get "/brands/:id/parts", to: redirect{ |params, request|
    brand = BrandMate.find_conglomerate_by_id params[:id]
    #http://192.168.1.251/brands/411445140/parts
    Rails.application.routes.url_helpers.brand_path(brand)
    #"/brands/#{brand.id}"
  }

  # /catalogs/brands/дочерний_id -> /catalogs/brands/родительский_id
  get "/catalogs/brands/:id", constraints: lambda{|params, env| BrandMate.find_company_by_id(params[:id]).try(:id) != params[:id].to_i }, to: redirect{|params, request|
    query_string = "?#{request.query_string}" if request.query_string.present?
    "/catalogs/brands/#{BrandMate.find_company_by_id(params[:id]).to_param}#{query_string}"
  }

  # /brands/дочерний_id -> /brands/родительский_id
  get "/brands/:id", constraints: lambda{|params, env| params[:id] != 'search' && BrandMate.find_conglomerate_by_id(params[:id]).try(:id) != params[:id].to_i }, to: redirect{|params, request|
    query_string = "?#{request.query_string}" if request.query_string.present?
    "/brands/#{BrandMate.find_conglomerate_by_id(params[:id]).to_param}#{query_string}"
  }

  # /categories/категория/brands/дочерний_id -> /categories/категория/brands/родительский_id
  get "/categories/:category_id/brands/:id", constraints: lambda{|params, env| BrandMate.find_company_by_id(params[:id]).try(:id) != params[:id].to_i }, to: redirect{|params, request|
    query_string = "?#{request.query_string}" if request.query_string.present?
    "/categories/#{params[:category_id]}/brands/#{BrandMate.find_company_by_id(params[:id]).to_param}#{query_string}"
  }

  concern :paginatable_index do
      get '(page/:page)', :action => :index, :on => :collection
  end

  concern :paginatable_show do
      get '(page/:page)', :action => :show, :on => :member
  end

  resource :catalogs do
    scope module: 'catalogs' do
      resources :brands
      resources :models
    end
  end

  resources :categories, concerns: [:paginatable_show] do
    scope module: 'categories' do
      #resources :brands, constraints: lambda {|request|
      #  request.params[:q][:accumulator_battery_capacity_gt].to_i > 10 && request.params[:q][:accumulator_battery_capacity_lt].to_i < 100
      #}, defaults: {accumulator: 'Аккумуляторы от 10 до 100'}
      resources :brands, concerns: [:paginatable_show]
      resources :models, concerns: [:paginatable_show]
      resources :generations, concerns: [:paginatable_show]
      resources :modifications, concerns: [:paginatable_show]
    end
  end

  concern :searchable do
    get 'search', :on => :collection
  end

  concern :global_and_admin do
    resources :spare_catalogs, concerns: [:gridable, :searchable]
    resources :bots, concerns: [:gridable]
    resources :spare_infos, concerns: [:gridable, :transactionable, :searchable]
    resources :spare_replacements, concerns: [:gridable]
  end

  concern :only_admin do
    namespace :opts do
      resources :accumulators, concerns: [:gridable]
      resources :truck_tires, concerns: [:gridable]
    end

    resources :galleries, concerns: [:gridable]
  end

  concern :only_global do
    resources :faqs, only: [:index]
    resources :news, only: [:index]
  end

  concern :somebody_and_admin_somebody do
    resources :pings
  end

  resources :tests

  concern :aaa do
    resource :order_deliveries
  end

  concern :fast_editable do
    member do
      get 'fast_edit'
      get 'fast_show'
      patch 'fast_update'
    end
  end

  concern :cars_searchable do
    resources :brands, :models, :generations, :modifications, :concerns => [:transactionable, :gridable, :searchable]

    resources :brands, :shallow => true do
      resources :models, :shallow => true do
        resources :generations, :shallow => true do
          resources :modifications, :shallow => true
        end
      end
    end
  end


  concern :talkable do
    resources :talks
  end

  concern :cashable do
    resource :cashes, :only => [:new, :create, :show]
  end


  resources :chats

  # TODO проверить, помоему это очень старое и не нужное
  #resources :delivery_zone_variants
  #resources :delivery_zones

  resources :calls

  concern :legal_or_personal do
    resource :legal_or_personal, :only => [:edit, :update]
  end

  concern :gridable do
    match 'filter', :via => [:get, :post], :on => :collection, action: :index
    match 'info', :via => [:get, :post], :on => :member, action: :info
    match 'filters', :via => [:get, :post], :on => :collection, action: :filters
    match 'columns', :via => [:get, :post], :on => :collection, action: :columns
    concerns :fast_editable
  end

  concern :transactionable do
    get 'transactions', :on => :collection
    get 'transactions', :on => :member
    get 'transactions'
  end

  concern :profileable do
    ['name', 'phone', 'email', 'passport', 'profile', 'postal_address', 'car', 'company'].each do |item|
      instance_eval <<-CODE, __FILE__, __LINE__ + 1
        resources :#{item.pluralize} do
          concerns :transactionable
          concerns :gridable
          if ['email', 'phone'].include? item
            member do
              scope 'confirm', as: 'confirm' do
                get 'make' => 'confirms#make', resource_class: '#{item.camelcase}'
                get 'view' => 'confirms#view', resource_class: '#{item.camelcase}'
                post 'ask' => 'confirms#ask', resource_class: '#{item.camelcase}'
              end
            end
          end
        end
      CODE
    end
  end

  concern :accountable do
    resources :accounts, :only => ['transactions'] do
      collection do
        get 'transactions'
      end
    end
  end

  #concern :productable do
  #  namespace :products do
  #    resources :incart
  #    resources :ordered
  #    resources :cancel
  #    resources :pre_supplier
  #    resources :post_supplier
  #    resources :stock
  #    resources :complete
  #    resources :return
  #    resources :multiple_destroy
  #    resources :inorder do
  #      member do
  #        match 'legal', :via => [:get, :patch]
  #        match 'delivery', :via => [:get, :patch]
  #        match 'action', :via => [:get, :patch]
  #      end
  #      collection do
  #        post 'order'
  #      end
  #    end
  #  end
  #end

  concern :complex_products do
    resources :products do
      collection do
        get 'incart'
        get 'inorder'
        match 'inorder_action', via: [:get, :post]
        get 'ordered'
        get 'pre_supplier'
        get 'post_supplier'
        match 'post_supplier_action', via: [:get, :post]
        get 'stock'
        get 'complete'
        get 'cancel'
        get 'multiple_destroy'
      end

      resources :products
      resource :split, :only => [:new, :create, :show]

      concerns :transactionable
      concerns :gridable
      collection do
        get 'status/:status' => "products#index", :as => :status
      end
    end
  end

  concern :complex_orders do
    resources :orders do
      collection do
        get 'status/:status' => "orders#index", :as => :status
      end
      concerns :gridable
      concerns :transactionable
      #concerns :productable

      concerns :complex_products

      member do
        resource :consignee, module: 'orders'
        resource :delivery, module: 'orders'
      end

      #member do
      #  get 'delivery' => 'orders/delivery#edit'
      #  patch 'delivery' => 'orders/delivery#update'
      #  get 'consignee' => 'orders/consignee#edit'
      #  patch 'consignee' => 'orders/consignee#update'
      #end
    end
  end

  namespace :manage do
    resources :phrases
  end

  namespace :admin do
    concerns :global_and_admin
    concerns :only_admin

    concerns :talkable
    concerns :accountable

    namespace :deliveries do
      resources :options do
        concerns :gridable
      end
      resources :places do
        concerns :gridable
      end
    end

    resources :calls

    resources :blocks

    concerns :cars_searchable

    resources :uploads

    #get 'pages/new/:path' => "pages#new", :as => 'new_predefined_page', :constraints => {:path => /.*/}


    # ПОСЛЕ ЭТОЙ СТРОКИ ИДУТ НЕ ПОВТОРЯЮЩИЕСЯ МАРШРУТЫ ТОЛЬКО В АДМИНИСТРАТИВНОЙ ЧАСТИ САЙТА

    resources :suppliers do
      concerns :accountable
      concerns :profileable
      concerns :gridable
      concerns :complex_products
      concerns :transactionable
      #resources :products do
      #  concerns :transactionable
      #end
      concerns :cashable

      concerns :talkable
    end

    concerns :profileable
    #concerns :productable
    concerns :complex_products
    concerns :complex_orders

    resources :spare_applicabilities do
      concerns :gridable
      concerns :transactionable
    end

    resources :users do
      concerns :somebody_and_admin_somebody
      concerns :aaa

      concerns :accountable
      concerns :profileable

      concerns :gridable
      concerns :transactionable

      #concerns :productable
      concerns :complex_products
      concerns :complex_orders

      concerns :cashable
      #get :password, action: "passwords#edit"
      #patch :password, action: "passwords#update"
      resource :password, :only => [:edit, :update]

      concerns :legal_or_personal
      delete :logout_from_all_places, on: :member


      concerns :talkable
    end


    # СОМНИТЕЛЬНЫЕ МАРШРУТЫ
    #resources :emails do
    #  member do
    #    get 'show_body'
    #    get 'show_text_part'
    #    get 'show_html_part'
    #    get 'show_html_part_sanitized'
    #  end
    #end


  end

  resource :user  do
    concerns :aaa

    resources :payments do
      member do
        get :print
      end
    end

    concerns :somebody_and_admin_somebody
    concerns :accountable
    concerns :profileable
    #concerns :productable
    concerns :complex_products
    concerns :transactionable
    concerns :complex_orders
    concerns :legal_or_personal
    resource :password, :only => [:edit, :update]
    #get :password, :on => :member, action: "passwords#edit"
    #patch :password, :on => :member, action: "passwords#update"
    delete :logout_from_all_places
    concerns :talkable
    post 'pretype', action: 'users#update'
  end
  resources :uploads do
    member do
      get 'crop'
      get 'rotate'
    end
  end

  resources :attachments

  get 'admin' => 'admin/welcome#index'

  root :to => 'welcome#index'

  resource :register
  resource :password_reset do
    collection do
      match 'contacts', via: [:get, :post]
      match 'pin', via: [:get, :post]
      get 'password'
      post 'done'
    end
  end

  # SESSION
  get '/login' => 'sessions#show'
  constraints with: /phone|email/ do
    get '/login(/:with)' => 'sessions#new', as: :login_with
    post '/login(/:with)' => 'sessions#create'
  end
  delete '/logout' => 'sessions#destroy'
  # /SESSION

  #scope '/call', as: :call, defaults: {with: 'call'} do
  #  resource :register
  #end

  #scope '/social', as: :social, defaults: {with: 'social'} do
  #  resource :register
  #end

  # OMNIAUTH
  get '/auth/:provider/callback' => 'auth#create'
  get '/auth/failure' => 'auth#failure'

  # ROBOTS.TXT
  get 'robots.txt' => "robots_txt#index"

  # OPENSEARCH.XML
  get 'opensearch.xml' => "opensearch_xml#index"

  # STATS
  resources :stats, :only => [:create]

  post 'robokassa/result' => 'robokassa#result'
  post 'robokassa/success' => 'robokassa#success'
  post 'robokassa/fail' => 'robokassa#fail'

  concerns :global_and_admin
  concerns :only_global


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

  resources :deliveries

  concerns :cars_searchable

  resources :brands

  resources :callbacks, only: [:show, :create]

  ## TODO Для перехвата /searches/2102/KURYAKYN
  #resources :searches do
  #  #get 'search', :on => :collection, :as => 'search', :to => 'searches#index'
  #  match '(/:catalog_number(/:manufacturer))' => "searches#index", :on => :collection, :as => 'search', :via => :get
  #  #match '?skip' => "searches#index", :on => :collection, :as => :skip_search, :via => :get
  #end

  # TODO Удалить как поисковые роботы перестроятся
  get "*brand", constraints: BrandRedirector.new, to: redirect{|params, req|
    brand = BrandMate.find_conglomerate((params[:brand]).gsub('+', ' '))
    "/brands/#{brand.to_param}"
  }


  require 'sidekiq/web'

  Sidekiq::Web.use Rack::Auth::Basic do |username, password|
    username == 'woto' && password == 'woto'
  end if Rails.env.production?

  mount Sidekiq::Web => '/sidekiq'

  mount Ckpages::Engine => "/ckpages"

end
