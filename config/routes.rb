Yaponama2012::Application.routes.draw do

  resources :talks do
    collection do
      get 'item'
    end
  end


  resources :calls

  concern :loginable do
    get 'login' => 'sessions#new', :as => 'login'
    post 'login' => 'sessions#create', :as => 'login'
    delete 'logout' => 'sessions#destroy', :as => 'logout'
  end

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
  end

  concerns :loginable

  resources :comments

  resources :uploads

  resources :pages

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

  resources :stats do
    collection do
      get :events
    end
  end

  resource :user  do
    concerns :profileable
  end

  namespace :admin do
      resources :calls

      resources :users do
        concerns :profileable
      end

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

    resources :spare_infos
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
