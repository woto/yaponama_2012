# encoding: utf-8
#
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include CurrentUserInModel
  include SmsSenderHelper
  helper_method :current_user
  helper_method :admin_zone?
  helper_method :public_zone?
  helper_method :jaba3
  #helper_method :complex_namespace_helper
  helper_method :smart_route
  around_action :set_user_time_zone
  before_action :ipgeobase
  helper_method :visible_columns
  helper_method :available_columns

  helper_method :sort_column
  helper_method :sort_direction

  before_action :set_resource_class

  before_action :somebody_set
  before_action :user_set
  before_action :supplier_set

  before_action :find_resource, except: [:new, :create, :index]

  # Потом вынести в concern transactionable?
  skip_before_action :find_resource, only: [:transactions]

  before_action :somebody_get, only: [:show, :edit, :update, :destroy]
  before_action :user_get, only: [:show, :edit, :update, :destroy]
  before_action :supplier_get, only: [:show, :edit, :update, :destroy]

  before_action :new_resource, only: [:new]
  before_action :edit_resource, only: [:edit]
  before_action :create_resource, only: [:create]
  before_action :update_resource, only: [:update]

  before_action :set_user_and_creation_reason, only: [:create, :update]

  #before_filter :set_cache_buster

  # Twitter Bootstrap 3
  add_flash_types :success, :info, :warning, :danger

  unless Rails.application.config.consider_all_requests_local
    rescue_from Exception, :with => :render_500
    rescue_from ActionController::RoutingError, :with => :render_404
    rescue_from ActionController::UnknownController, :with => :render_404
    rescue_from ActiveRecord::RecordNotFound, :with => :render_500
  end

  rescue_from AuthenticationError, with: -> { redirect_to root_path, danger: "Возможно вы или кто-то другой входил на сайт под вашей учетной записью с другого компьютера. Вы можете отключить функцию автоматического выхода в Личном кабинете для возможности одновременной работы с разных компьютеров." }
  
  def info
    render :layout => false
  end

  def columns
    render "grid_modal_columns", :layout => false
  end

  def filters
    render "grid_modal_filters", :layout => false
  end

  def index
    respond_to do |format|
      format.html
      format.js { render 'grid_filter' }
    end
  end

  def new
  end

  def edit
  end

  def show
  end

  def create
    # TODO postal_address_type здесь нужен для того чтобы после создания адреса доставки переброска на show происходила с postal_address_type, чтобы на следующем шаге мы знали показывать например поле для ввода квартиры или нет. Потом как-нибудь подумать, как сделать лучше
    respond_to do |format|
      if @resource.save
        format.html { redirect_to url_for(:action => :show, :return_path => params[:return_path], :postal_address_type => params[:postal_address_type], :id => @resource.id) }
        format.js { redirect_to url_for(:action => :show, :return_path => params[:return_path], :postal_address_type => params[:postal_address_type], :id => @resource.id) }
      else
        format.html { render action: 'new' }
        format.js { render action: 'new' }
      end
    end
  end

  def update
    respond_to do |format|
      if @resource.save
        format.html { redirect_to url_for(:action => :show, :return_path => params[:return_path]) }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @resource.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @resource.destroy
        format.html { redirect_to url_for(params[:return_path]), success: "#{@resource_class} was successfully destroyed" }
        format.json { head :no_content }
      else
        format.html { redirect_to url_for(:controller => :users, :action => :show), danger: "Невозможно удалить." }
      end
    end
  end

  private

  #def set_cache_buster
  #  response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
  #  response.headers["Pragma"] = "no-cache"
  #  response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  #end

  def ipgeobase

    # GEO
    remote_ip = request.remote_ip

    if current_user.remote_ip != remote_ip
      res = Ipgeobase::find_region_by_ip(remote_ip)
      current_user.remote_ip = remote_ip
      current_user.ipgeobase_name = res && res.name || ''
      current_user.ipgeobase_names_depth_cache = res && res.names_depth_cache || ''
    end

    current_user.user_agent                = request.user_agent.to_s
    current_user.accept_language           = request.accept_language.to_s

    current_user.cached_location = request.protocol + request.host_with_port + request.original_fullpath
    current_user.cached_referrer = request.referer

    # BOT

    bot = false

    if Bot.where("? <<= inet", remote_ip).present?
      bot = true
    end

    if Bot.where(Bot.arel_table[:user_agent].matches("%#{current_user.user_agent}%")).present?
      bot = true
    end

    current_user.bot = bot

    current_user.save!
  end

  def item_status(catalog_number, manufacturer)
    status = {
      :own => {:status => 'unavaliable', :data => nil},
    }

    # Наши данные
    spare_info = SpareInfo.where(:catalog_number => catalog_number, :cached_brand => manufacturer).first

    if spare_info.present?
      status[:own][:status] = 'avaliable'
      status[:own][:data] = spare_info
    end

    return status
  end

  # TODO потом детальнее посмотреть где и как используются @exception
  def render_404(exception)
    @exception = exception
    Rails.logger.error(exception)
    respond_to do |format|
      format.all { render :template => 'errors/error_404', :layout => 'layouts/application', :status => 404 }
    end
  end


  def render_500(exception)
    @exception = exception
    Rails.logger.error(exception)
    respond_to do |format|
      format.all { render :template => 'errors/error_500', :layout => 'layouts/application', :status => 500 }
    end
  end


  def admin_zone?
    params[:controller].partition('/').first == 'admin'
  end

  def jaba3
    [
      (admin_zone? ? :admin : :user),
      (admin_zone? ? @somebody : nil)
    ]
  end



  def public_zone?
    !admin_zone?
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

    polymorphic_path(res, second)

  end

  def current_user
    unless @current_user
      if cookies[:auth_token].present?
        @current_user = User.find_by(auth_token: cookies[:auth_token])
        unless @current_user.present?
          cookies.delete :auth_token
          raise AuthenticationError
        end
      else
        @current_user = User.new
        @current_user.assign_attributes(SiteConfig.default_somebody_attributes)
        @current_user.code_1 = 'session'
        @current_user.build_account
        @current_user.phantom = false
        #@current_user.online = true
        @current_user.save!
        cookies.permanent[:auth_token] = @current_user.auth_token
      end

    end
    @current_user
  end

  def commentable_helper obj
    @comments = Comment.where(:commentable_id => obj.id, :commentable_type => obj.class).arrange(:order => :created_at)
    @comment = Comment.new()
    @comment.commentable = obj
    @name = current_user.names.where(:creation_reason => Rails.configuration.name_creation_reason['self']).first.try(:to_label)
    @email = current_user.emails.first.try(:to_label)
  end


  def set_user_time_zone

    tz = case current_user.use_auto_russian_time_zone
    when true
      if Rails.configuration.russian_time_zones.key?(current_user.cached_russian_time_zone_auto_id.to_s)
        current_user.cached_russian_time_zone_auto_id
      else
        # Несмотря на то, что такая временная зона может и есть, в России её нет.
        # Поэтому для других стран пусть показвается дефолтной выбранное в настройках сайта (т.е. локальное для этого места)
        SiteConfig.default_time_zone_id.to_i
      end
    else
      current_user.russian_time_zone_manual_id
    end

    Time.use_zone(tz) {
      yield
    }

  end

  def only_not_authenticated
    if ["admin", "manager", "user"].include? current_user.role
      redirect_to root_path, :info => "Вы уже вошли на сайт." and return
    end
  end

  def only_authenticated
    if ['guest'].include? current_user.role
      redirect_to root_path, :danger => "Пожалуйста войдите на сайт." and return
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

  def find_resource
    @resource = @resource_class.find(params[:id])
  end

  def new_resource
    @resource = @resource_class.new resource_params
  end

  def edit_resource
  end

  def create_resource
    #binding.pry
    @resource = @resource_class.new(resource_params)
  end

  def update_resource
    @resource.assign_attributes(resource_params)
  end

  def set_user_and_creation_reason
    #debugger
    # #TODO вроде не правильно && ... не должно быть нужно
    if @resource.respond_to?(:somebody) && @resource.somebody.blank?
      @resource.somebody = @somebody
    end

    # TODO черновой вариант
    if @resource.respond_to?(:creator) && !(@resource.persisted? && @resource.is_a?(Talk))
      @resource.creator = current_user
    end

    if @resource.respond_to? :code_1=
      @resource.code_1 = 'frontend'
    end
  end

  def resource_params
    # TODO DANGER!
    params.fetch(@resource_class.name.underscore.gsub('/', '_').to_sym, {}).permit!
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
    @user = @resource.somebody if @resource && @resource.respond_to?(:somebody)
  end

  def somebody_get
    #binding.pry
    @somebody = @resource.somebody if @resource && @resource.respond_to?(:somebody)
  end

  def supplier_get
    #binding.pry
    @supplier = @resource.supplier if @resource && @resource.respond_to?(:supplier)
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


end
