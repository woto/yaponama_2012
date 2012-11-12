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
      #post 'makes' => 'orders/build#create'
      #resources :build, :controller => 'orders/build'
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
      match 'inorder_form', :on => :collection
      match 'inorder_action', :on => :collection
      match 'remember', :on => :collection

      member do
        match 'set_to_pre_supplier_form'
        match 'set_to_pre_supplier_action'
        match 'set_to_post_supplier_action'
        match 'set_cancel_action'
        match 'set_cart_action'
        match 'set_stock_action'
        match 'set_complete_action'
      end

      collection do
        match 'inorder_step_one'
        match 'inorder_step_two'
        match 'inorder_step_three'
        match 'multiple_form'
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

  get 'clear_order_session' => "admin::products#clear_order_session"
  root :to => 'welcome#index'

end
