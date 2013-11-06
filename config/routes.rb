class BrandConstraint
  def initialize
    #@ips = Blacklist.retrieve_ips
    #@brand_names = Brand.pluck(:name)
  end

  def matches?(request)
    #@ips.include?(request.remote_ip)
    @brand_names = Brand.pluck(:name)
    @brand_names.include? CGI.unescape(request.params[:brand])
  end
end

class PageConstraint
  def matches?(request)
    @page = Page.where(:path => request.params[:path])
    @page.present?
  end
end

Yaponama2012::Application.routes.draw do

  namespace :admin do
    resources :blocks
  end

  resources :tests

  concern :talkable do
    resources :talks do
      collection do
        get 'item'
      end
    end
  end

  concern :cashable do
    resource :cashes, :only => [:new, :create]
  end

  concern :letter do
    #resources :letter_parts

    resources :letters do
      member do
        get :download
      end
      resources :letter_parts do
        get 'cid/:cid', to: "letter_parts#cid", on: :collection, cid: /.*/
      end
    end
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
    match 'filter', :via => [:get, :post], :on => :collection, to: :index
    match 'info', :via => [:get, :post], :on => :member, to: :info
    match 'filters', :via => [:get, :post], :on => :collection, to: :filters
    match 'columns', :via => [:get, :post], :on => :collection, to: :columns
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


  concern :parts_searchable do
    resources :searches do
      get 'search', :on => :collection, :as => 'search', :to => 'searches#index'
      #match '(/:catalog_number(/:manufacturer))' => "searches#index", :on => :collection, :as => 'search', :via => :get
      #match '?skip' => "searches#index", :on => :collection, :as => :skip_search, :via => :get
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
        get 'ordered'
        get 'pre_supplier'
        get 'post_supplier'
        post 'post_supplier_action'
        get 'stock'
        get 'complete'
        get 'cancel'
        get 'multiple_destroy'
      end

      resources :products
      resource :split, :only => [:new, :create]

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
    end
  end

  namespace :admin do
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

    concern :searchable do
      get 'search', :on => :collection
    end

    resources :brands, :models, :generations, :modifications, :concerns => [:transactionable, :gridable, :searchable]

    resources :brands, :shallow => true do
      resources :models, :shallow => true do
        resources :generations, :shallow => true do
          resources :modifications, :shallow => true
        end
      end
    end

    resources :uploads

    get 'pages/new/:path' => "pages#new", :as => 'new_predefined_page', :constraints => {:path => /.*/}

    resources :pages do
      concerns :gridable
      concerns :transactionable
    end


    # ПОСЛЕ ЭТОЙ СТРОКИ ИДУТ НЕ ПОВТОРЯЮЩИЕСЯ МАРШРУТЫ ТОЛЬКО В АДМИНИСТРАТИВНОЙ ЧАСТИ САЙТА

    resources :site_settings

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
    end

    concerns :profileable
    #concerns :productable
    concerns :complex_products
    concerns :complex_orders

    resources :spare_infos do
      concerns :gridable
      concerns :transactionable
    end


    resources :users do
      concerns :accountable
      concerns :profileable

      concerns :gridable
      concerns :transactionable

      concerns :letter
      concerns :parts_searchable

      #concerns :productable
      concerns :complex_products
      concerns :complex_orders

      concerns :cashable
      get :password, :on => :member, to: "passwords#edit"
      patch :password, :on => :member, to: "passwords#update"
      #resource :password, :only => [:edit, :update]
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

  resources :spare_infos

  resource :user  do
    concerns :accountable
    concerns :profileable
    #concerns :productable
    concerns :complex_products
    concerns :transactionable
    concerns :complex_orders
    concerns :legal_or_personal
    concerns :parts_searchable
    #resource :password, :only => [:edit, :update]
    get :password, :on => :member, to: "passwords#edit"
    patch :password, :on => :member, to: "passwords#update"
    delete :logout_from_all_places
    concerns :talkable
    concerns :cashable
  end

  resources :comments
  resources :uploads do
    member do
      get 'crop'
      get 'rotate'
    end
  end

  resources :attachments


  get 'admin' => 'admin/users#index'

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

  resources :deliveries

  get "*brand" => "brands#show", :constraints => BrandConstraint.new
  get "*path" => "pages#show", :constraints => PageConstraint.new

end
