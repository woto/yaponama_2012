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
          match 'action'
        end
        collection do
          match 'order_select'
        end
      end
    end

    resources :products do
      resources :product_transactions
      collection do
        match 'remember'
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

  get 'clear_session' => "trash_help#clear_session"

  root :to => 'admin/users#index'

end
