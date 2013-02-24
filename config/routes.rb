Yaponama2012::Application.routes.draw do

  concern :loginable do
    get 'login' => 'sessions#new', :as => 'login'
    post 'login' => 'sessions#create', :as => 'login'
    delete 'logout' => 'sessions#destroy', :as => 'logout'
  end

  concerns :loginable

  resources :comments

  resources :uploads

  resources :pages

  get "register" => "users#edit", :as => "register"
  patch "register" => "users#update"

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

  get 'robots.txt' => "robots_txt#index"


  root :to => 'index#index'

  resources :stats

  namespace :admin do

    resources :stats do
      get "iframe", :on => :member
    end


    resources :blocks

    concern :searchable do
      get 'search', :on => :collection
    end

    concerns :loginable

    resources :models, :generations, :modifications, :brands, concerns: :searchable

    resources :site_settings

    resources :uploads

    get 'pages/new/:path' => "pages#new", :as => 'new_predefined_page', :constraints => {:path => /.*/}
    resources :pages

    get 'users' => 'users#index', :as => 'root'

    resources :password_resets
    #resources :sessions

    resources :metro
    resources :delivery_categories
    resources :deliveries
    resources :companies

    resources :orders do
      resources :products
    end

    resources :users do


      resources :products

      resources :orders do
        resources :products
      end

      resources :money_transactions
      resources :product_transactions

      collection do
        post 'filter' => "users#index"
      end

    end

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

    resources :products do
      resources :product_transactions
      collection do
        post 'remember'
        delete 'multiple_destroy' => "products#multiple_destroy"
      end
      
    end

    resources :names
    resources :spare_infos
    resources :time_zones
    resources :email_addresses

    resources :emails do
      member do
        get 'show_body'
        get 'show_text_part'
        get 'show_html_part'
        get 'show_html_part_sanitized'
      end
    end

    resources :requests
    resources :accounts
    resources :money_transactions
    resources :product_transactions
    resources :suppliers do
      resources :money_transactions
      resources :product_transactions
    end

  end

  # Omniauth
  get '/auth/:provider/callback' => 'auth#create'
  get '/auth/failure' => 'auth#failure'

  get "*path" => "pages#index"

end
