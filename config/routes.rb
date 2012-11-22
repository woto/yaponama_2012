Yaponama2012::Application.routes.draw do


  #get "build/show"
  #get "build/update"
  #get "build/create"

  get 'trash_help/index'
  post 'trash_help/merge'
  post 'trash_help/make_payment'
  namespace 'trash_help' do
    post 'check_orders_inorder'
  end
  post 'trash_help/make_payment_to_supplier'

  resources :attachments

  mount Ckeditor::Engine => '/ckeditor'

  namespace :admin do

    resources :delivery_categories
    resources :deliveries
    resources :companies

    resources :orders do
      resources :products
    end

    resources :users do
      resources :products
    end

    resources :users do
      resources :orders do
        resources :products
      end
    end

    resources :products do

      collection do

        match 'remember'

        # TODO How to make it DRY?
        get 'incart' => "products/incart#index"
        put 'incart' => "products/incart#update"

        get 'ordered' => "products/ordered#index"
        put 'ordered' => "products/ordered#update"

        get 'cancel' => "products/cancel#index"
        put 'cancel' => "products/cancel#update"
        
        get 'pre_supplier' => "products/pre_supplier#index"
        put 'pre_supplier' => "products/pre_supplier#update"

        get 'post_supplier' => "products/post_supplier#index"
        put 'post_supplier' => "products/post_supplier#update"

        get 'stock' => "products/stock#index"
        put 'stock' => "products/stock#update"

        get 'complete' => "products/complete#index"
        put 'complete' => "products/complete#update"

        get 'return' => "products/return#index"
        put 'return' => "products/return#update"

        get 'inorder' => "products/inorder#index"
        match 'order_select' => "products/inorder#order_select"

        match 'doit' => "products/inorder#doit_create"

        delete 'multiple_destroy' => "products#multiple_destroy"

      end

      member do
        #match 'split' => "products/split#index"
        #match 'split' => "products/split#index"
        get 'split' => "products/split#index"
        put 'split' => "products/split#update"

        match 'action' => "products/inorder#action"
        match 'doit' => "products/inorder#doit_update"

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
    resources :users do
      collection do
        post 'filter' => "users#index"
      end
    end
    resources :requests
    resources :accounts
    resources :transactions
    resources :suppliers

  end

  get 'clear_session' => "trash_help#clear_session"

  root :to => 'admin/users#index'

end
