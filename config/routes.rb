Yaponama2012::Application.routes.draw do


  resources :uploads

  resources :pages

  get "register" => "users#edit", :as => "register"
  put "register" => "users#update"
  get 'login' => 'sessions#new', :as => 'login'
  post 'login' => 'sessions#create', :as => 'login'
  resources :password_resets
  delete 'logout' => 'sessions#destroy', :as => 'logout'
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


  root :to => 'trash_help#index'

end
