#encoding: utf-8

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include CurrentUserInModel
  include SmsSenderHelper
  helper_method :current_user
  helper_method :namespace_helper
  helper_method :complex_namespace_helper
  before_action :set_user_time_zone

  private

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


  def namespace_helper
    namespace = nil

    if slash_index = params[:controller].index('/')
      namespace = params[:controller][0...slash_index]
    end

    namespace
  end

  def complex_namespace_helper
    [namespace_helper, namespace_helper == 'admin' ? @user : :user]
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
    Time.zone = current_user.russian_time_zone_manual_id || current_user.russian_time_zone_auto_id
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

end
