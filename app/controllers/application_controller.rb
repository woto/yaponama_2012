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
  #helper_method :complex_namespace_helper
  helper_method :smart_route
  around_action :set_user_time_zone
  before_action :ipgeobase
  helper_method :visible_columns
  helper_method :available_columns

  helper_method :sort_column
  helper_method :sort_direction

  before_filter :set_cache_buster

  #helper :tag

  # Twitter Bootstrap 3
  add_flash_types :success, :info, :warning, :danger


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
    respond_to do |format|
      if @resource.save
        format.html { redirect_to url_for(:action => :show, :return_path => params[:return_path], :id => @resource.id), success: "#{@resource_class} was successfully created." }
      else
        format.html { render action: 'new' }
      end
    end
  end

  def update
    respond_to do |format|
      if @resource.update(resource_params)
        format.html { redirect_to url_for(:action => :show, :return_path => params[:return_path]), success: "#{@resource_class} was successfully updated." }
      else
        format.html { render action: 'edit' }
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

  def set_cache_buster
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end

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

  unless Rails.application.config.consider_all_requests_local
    rescue_from Exception, :with => :render_500
    rescue_from ActionController::RoutingError, :with => :render_404
    rescue_from ActionController::UnknownController, :with => :render_404
    rescue_from ActiveRecord::RecordNotFound, :with => :render_404
  end

  rescue_from AuthenticationError, with: -> { redirect_to root_path, danger: "Возможно вы или кто-то другой входил на сайт под вашей учетной записью с другого компьютера. Вы можете отключить функцию автоматического выхода в Личном кабинете для возможности одновременной работы с разных компьютеров." }
  
  # TODO потом детальнее посмотреть где и как используются @show_sidebar и @exception
  def render_404(exception)
    @show_sidebar = true
    @exception = exception
    Rails.logger.error(exception)
    respond_to do |format|
      format.all { render :template => 'errors/error_404', :layout => 'layouts/application', :status => 404 }
    end
  end


  def render_500(exception)
    @show_sidebar = true
    @exception = exception
    Rails.logger.error(exception)
    respond_to do |format|
      format.all { render :template => 'errors/error_500', :layout => 'layouts/application', :status => 500 }
    end
  end


  def admin_zone?
    params[:controller].partition('/').first == 'admin'
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
        @current_user.online = true
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


private

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

  private

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

  before_action :set_resource_class

  before_action :user_set
  before_action :somebody_set
  before_action :supplier_set

  before_action :find_resource, except: [:new, :create, :index]

  # Потом вынести в concern transactionable?
  skip_before_action :find_resource, :only => [:transactions]

  def find_resource
    @resource = @resource_class.find(params[:id])
  end

  before_action :user_get, :only => [:show, :edit, :update, :destroy]
  before_action :supplier_get, :only => [:show, :edit, :update, :destroy]
  before_action :somebody_get, :only => [:show, :edit, :update, :destroy]

  before_action :new_resource, :only => [:new]

  def new_resource
    @resource = @resource_class.new
  end

  before_action :edit_resource, only: [:edit]

  def edit_resource
  end

  before_action :create_resource, :only => [:create]

  def create_resource
    @resource = @resource_class.new(resource_params)
  end

  before_action :update_resource, :only => [:update]

  def update_resource
    @resource.assign_attributes(resource_params)
  end


  before_action :set_user_and_creation_reason, :only => [:create, :update]

  def set_user_and_creation_reason
    if @resource.respond_to? :somebody
      @resource.somebody = @somebody
    end

    if @resource.respond_to? :creator
      @resource.creator = current_user.creator
    end

    if @resource.respond_to? :code_1=
      @resource.code_1 = 'frontend'
    end
  end


  def resource_params
    # TODO DANGER!
    params.require(@resource_class.name.underscore.gsub('/', '_').to_sym).permit!
  end

end
