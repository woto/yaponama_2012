# TODO Удалить как поисковые роботы перестроятся
class BrandRedirector
  def matches?(request)
    Brand.find_by(name: CGI.unescape(request.params[:brand]))
  end
end


Yaponama2012::Application.routes.draw do

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords',
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

    resources :bots do
      get :preview, on: :member
    end
    resources :spare_infos, concerns: [:searchable]
    resources :spare_catalogs, concerns: [:searchable]
    resources :spare_replacements
  end

  concern :only_admin do
    root to: 'welcome#index'
    resources :spare_catalog_groups
    namespace :opts do
      resources :accumulators
      resources :truck_tires
    end
    resources :users do
      get :impersonate, on: :member
    end
    resources :orders
    resources :galleries

    namespace :guess do
      resource :car
    end

  end

  concern :only_global do
    resources :faqs, only: [:index, :show]
    resources :news, only: [:index]
    resources :deliveries
  end

  concern :cars_searchable do
    resources :brands, :models, :generations, :modifications, :concerns => [:searchable]

    resources :brands, :shallow => true do
      resources :models, :shallow => true do
        resources :generations, :shallow => true do
          resources :modifications, :shallow => true
        end
      end
    end
  end


  namespace :manage do
    resources :phrases
  end

  namespace :admin do
    concerns :global_and_admin
    concerns :only_admin
    namespace :deliveries do
      resources :places
    end
    resources :calls
    resources :blocks
    concerns :cars_searchable
    resources :uploads
    resources :spare_applicabilities
    resources :phrases
  end

  namespace :user do
    get 'discourse/sso'
  end

  resource :user  do
    resources :products
    scope module: :user do
      resources :cart, only: [:index, :update] do
        delete :confirm_remove, on: :member
      end
      resources :orders, only: [:new, :create], controller: 'orders/shops', constraints: ->(request) { request.params.try(:[], :orders_shop_form).try(:[], :deliveries_place_id).present? }
      resources :orders, only: [:new, :create], controller: 'orders/deliveries'
      #resources :orders, only: [:show]
      resources :postal_addresses
      resources :cars
      post :pings, to: "deprecated#create"
    end
  end

  # TODO temporary solution
  get '/user/orders/:id', to: redirect('/user'), as: :user_order

  root :to => 'welcome#index'

  # ROBOTS.TXT
  get 'robots.txt' => "robots_txt#index"

  # OPENSEARCH.XML
  get 'opensearch.xml' => "opensearch_xml#index"

  concerns :global_and_admin
  concerns :only_global
  concerns :cars_searchable
  resources :brands

  post :stats, to: "deprecated#create"

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
    username == Rails.application.secrets.sidekiq_username && password == Rails.application.secrets.sidekiq_password
  end if Rails.env.production?
  mount Sidekiq::Web => '/sidekiq'
  mount Ckpages::Engine => "/ckpages"
end
