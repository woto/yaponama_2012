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
      match 'inorder_index', :on => :collection
      match 'inorder_order_select', :on => :collection
      match 'inorder_action', :on => :member
      #match 'inorder_create', :on => :member

      match 'inorder_doit' => "orders#inorder_doit_create", :on => :collection
      match 'inorder_doit' => "orders#inorder_doit_update", :on => :member

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
        get 'split' => "products/split#index"
        put 'split' => "products/split#update"

        get 'incart' => "products/incart#index"
        put 'incart' => "products/incart#update"


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
