Yaponama2012::Application.routes.draw do

  namespace :admin do

    concern :searchable do
      get 'search', :on => :collection
    end

    resources :models, :generations, :modifications, :brands, concerns: :searchable

    resources :site_settings

    resources :uploads

    get 'pages/new/:path' => "pages#new", :as => 'new_predefined_page', :constraints => {:path => /.*/}
    resources :pages

    get 'users' => 'users#index', :as => 'root'

    get "register" => "users#edit", :as => "register"
    put "register" => "users#update"
    get "login" => "sessions#new", :as => "login"
    post 'login' => 'sessions#create', :as => 'login'
    resources :password_resets
    #resources :sessions
    delete 'logout' => 'sessions#destroy', :as => 'logout'

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

end
