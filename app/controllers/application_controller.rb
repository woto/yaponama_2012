#encoding: utf-8

class ApplicationController < ActionController::Base
  before_action :set_user
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include CurrentUserInModel
  include SmsSenderHelper
  helper_method :current_user
  helper_method :admin_zone?
  #helper_method :complex_namespace_helper
  helper_method :smart_route
  before_action :set_user_time_zone
  before_action :ipgeobase
  helper_method :visible_columns

  helper_method :sort_column
  helper_method :sort_direction

  before_filter :set_cache_buster



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
      if res
        current_user.ipgeobase_name = res.name
        current_user.ipgeobase_names_depth_cache = res.names_depth_cache
      end
    end

    current_user.remote_ip                 = remote_ip
    current_user.user_agent                = request.user_agent.to_s
    current_user.accept_language           = request.accept_language.to_s

  end

  def item_status(catalog_number, manufacturer)

    status = {
      :own => {:status => 'unavaliable', :data => nil},
      :their => {:status => 'unavaliable', :data => nil}
    }

    # Наши данные
    spare_info = SpareInfo.where(:catalog_number => catalog_number, :manufacturer => manufacturer)

    if spare_info.present?
      status[:own][:status] = 'avaliable'
      status[:own][:data] = spare_info
    end

    key_part = "#{catalog_number}:#{manufacturer}".mb_chars.gsub(/[^а-яА-Яa-zA-z0-9]/,'_')

    # Их данные
    begin
      File.open("#{Rails.root}/system/parts_info/f:#{key_part}", "r") do |file|
        if (status[:their][:status] = file.read) == 'avaliable'
          File.open("#{Rails.root}/system/parts_info/s:#{key_part}", "r") do |file|
            status[:their][:data] = file.read
          end
        end
      end
    rescue Exception => exc
      if exc.instance_of? Errno::ENOENT
        status[:their][:status] = 'unknown'
      end

     if SiteConfig.send_request_from_search_page
       require 'redis'
       redis = Redis.new(:host => SiteConfig.redis_address, :port => SiteConfig.redis_port)

       Juggernaut.publish(
       nil, {
         :command => 'info',
         :catalog_number => catalog_number,
         :manufacturer => manufacturer.presence || "WRONG_MANUFACTURER",
         :channel => 'server'
       }, {}, "custom")
      end

    end

    return status

  end


  unless Rails.application.config.consider_all_requests_local
    rescue_from Exception, :with => :render_500
    rescue_from ActionController::RoutingError, :with => :render_404
    rescue_from ActionController::UnknownController, :with => :render_404
    rescue_from AuthenticationError, with: -> { redirect_to root_path }
    rescue_from ActiveRecord::RecordNotFound, :with => :render_404
  end
  
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
        @current_user.assign_attributes(SiteConfig.default_user_attributes)
        @current_user.creation_reason = "session"
        @current_user.build_account
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
    @name = current_user.names.where(:creation_reason => Rails.configuration.user_name_creation_reason['self']).first.try(:to_label)
    @email_address = current_user.email_addresses.first.try(:to_label)
  end


private

  def set_user_time_zone
    Time.zone = case current_user.use_auto_russian_time_zone
    when true
      current_user.russian_time_zone_auto_id
    else
      current_user.russian_time_zone_manual_id
    end
  end

  private

  def only_not_authenticated
    if ["admin", "manager", "user"].include? current_user.role
      redirect_to root_path, :notice => "Вы уже вошли на сайт." and return
    end
  end

  def only_authenticated
    if ['guest'].include? current_user.role
      redirect_to root_path, :notice => "Пожалуйста войдите на сайт." and return
    end
  end

  def set_user
    @user = current_user
  end

  def visible_columns
    @visible_columns = []

    @grid_class::COLUMNS.each do |column_name, column_settings| 
      if eval("@grid.#{column_name}_visible") == '1'
        @visible_columns << column_name
      end
    end

    @visible_columns
  end

end
