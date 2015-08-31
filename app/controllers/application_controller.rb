class ApplicationController < ActionController::Base

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include CurrentUserInModel
  include SmsSenderHelper
  helper_method :current_user
  helper_method :jaba3
  #helper_method :complex_namespace_helper
  helper_method :smart_route
  before_action :stats, if: -> {current_user}
  helper_method :visible_columns
  helper_method :available_columns

  helper_method :sort_column
  helper_method :sort_direction


  before_action :somebody_set
  before_action :user_set
  before_action :supplier_set

  include Actions
  include Resource
  include Zone

  before_action :somebody_get, only: [:show, :edit, :update, :destroy]
  before_action :user_get, only: [:show, :edit, :update, :destroy]
  before_action :supplier_get, only: [:show, :edit, :update, :destroy]

  before_action :set_user_and_creation_reason, only: [:create, :update]

  #before_filter :set_cache_buster

  # Twitter Bootstrap 3
  add_flash_types :success, :info, :warning, :danger, :attention

  def columns
    render "grid_modal_columns", :layout => false
  end

  def filters
    render "grid_modal_filters", :layout => false
  end

  include ErrorHandling

  private

  def stats

    remote_ip = request.remote_ip

    if current_user.remote_ip != remote_ip
      res = Ipgeobase::find_region_by_ip(remote_ip)
      current_user.remote_ip = remote_ip
      current_user.ipgeobase_name = res && res.name || ''
      current_user.ipgeobase_names_depth_cache = res && res.names_depth_cache || ''
    end

    current_user.user_agent = request.user_agent.to_s
    current_user.accept_language = request.accept_language.to_s
    current_user.location = request.protocol + request.host_with_port + request.original_fullpath
    current_user.referrer = request.referer
    current_user.first_referrer = request.referer if current_user.first_referrer.nil?

    current_user.save!
  end

  def jaba3
    [
      (admin_zone? ? :admin : :user),
      (admin_zone? ? @somebody : nil)
    ]
  end


  #def complex_namespace_helper
  #  #(namespace_helper == 'admin') ? [namespace_helper, @user] : ( namespace_helper == 'products' ? [:user] : [:user])
  #  namespace_helper == 'admin' ? [namespace_helper, @user] : [:user]
  #end

  def smart_route(first, second = {})

    res = []

    res += first[:prefix] if first[:prefix]

    if params[:controller].include? 'admin'
      res += [:admin]
      if second[:user_id]
        res += [:user]
      end
    else
      res += [:user]
      second.delete :user_id if second[:user_id]
    end

    if second[:order_id]
      res += [:order]
    end

    res += first[:postfix] if first[:postfix]

    main_app.polymorphic_path(res, second)

  end

  def current_user

    unless defined? @current_user

      bot = Bot.matched_records_by_remote_ip(request.remote_ip).matched_records_by_user_agent(request.user_agent).first

      if bot
        if bot.block
          raise BanishError
        else
          @current_user = nil
        end
      else
        if cookies[:auth_token].present?
          @current_user = User.find_by(auth_token: cookies[:auth_token])
          unless @current_user.present?
            cookies.delete :auth_token
            raise AuthenticationError.new ''
          end
        else
          @current_user = User.new
          @current_user.assign_attributes(Rails.application.config_for('application/user')['default'])
          @current_user.code_1 = 'session'
          @current_user.build_account
          @current_user.phantom = false
          @current_user.save!
          cookies.permanent[:auth_token] = @current_user.auth_token
          cookies.permanent[:role] = 'guest'
        end
      end
    end

    @current_user
  end

  def only_not_authenticated
    if current_user && ["admin", "manager", "user"].include?(current_user.role)
      redirect_to root_path, :attention => "Вы уже вошли на сайт" and return
    end
  end

  def only_authenticated
    if ['guest'].include? current_user.role
      redirect_to root_path, :attention => "Пожалуйста войдите на сайт" and return
    end
  end

  def available_columns
    @available_columns ||= @grid_class::COLUMNS
  end

  def visible_columns
    @visible_columns = []

    @grid_class::COLUMNS.each do |column_name, column_settings| 
      if eval("@grid.visible_#{column_name}") == '1'
        @visible_columns << column_name
      end
    end

    @visible_columns
  end

  def set_user_and_creation_reason
    #binding.pry
    # #TODO вроде не правильно && ... не должно быть нужно
    if @resource.respond_to?(:somebody) && @resource.somebody.blank?
      @resource.somebody = @somebody
    end
  end

  def user_set
    #binding.pry
    @somebody = @user = current_user
  end
  
  def somebody_set
    #binding.pry
    #@somebody = current_user
  end

  def supplier_set
    #binding.pry
    @somebody = @supplier = current_user
  end


  def user_get
    #binding.pry
    @user = @resource.somebody if @resource && @resource.respond_to?(:somebody) && @resource.somebody.present?
  end

  def somebody_get
    #binding.pry
    @somebody = @resource.somebody if @resource && @resource.respond_to?(:somebody) && @resource.somebody.present?
  end

  def supplier_get
    #binding.pry
    @supplier = @resource.supplier if @resource && @resource.respond_to?(:supplier) && @resource.supplier.present?
  end

  def item_collection_params
    hash = { items: @items }
    hash.merge(params.fetch(:item_collection, {}).permit!)
  end

  def ugly_address

    if @somebody.postal_addresses.any?
      @order_delivery = OrderDelivery.new(postal_address_type: 'old')
    else
      @order_delivery = OrderDelivery.new(postal_address_type: 'new')
    end
    @order_delivery.new_postal_address = @somebody.postal_addresses.new(postcode: '000000', region: 'Москва', city: 'Москва')

  end

  helper_method :get_news

  def get_news

    #Rails.cache.delete('news') if current_user.seller?

    Rails.cache.fetch('news') do
      topics = $discourse.category_latest_topics('kompaniya/novosti').
        sort_by{|topic| topic['created_at']}.
        reverse

      topics = topics.select do |topic|
        topic['post'] = $discourse.topic(topic['id'])['post_stream']['posts'][0]['cooked']
      end
    end
  end

  helper_method :get_faqs

  def get_faqs

    Rails.cache.fetch('faqs') do
      topics = $discourse.category_latest_topics('kompaniya/chastye-voprosy').
        sort_by{|topic| topic['created_at']}.
        reverse

      topics = topics.select do |topic|
        topic['post'] = $discourse.topic(topic['id'])['post_stream']['posts'][0]['cooked']
      end
    end
  end

end
