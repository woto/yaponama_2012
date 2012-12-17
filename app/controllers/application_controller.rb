class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user
  around_filter :set_unset_current_user_in_model
  before_filter :create_user

  def set_unset_current_user_in_model
    User.current_user = current_user
    yield
  ensure
    User.current_user = nil
  end

  def current_user
    if session[:user_id] 
      begin
        @current_user = User.find(session[:user_id])
      rescue ActiveRecord::RecordNotFound => e
        reset_session
        redirect_to root_path and return
      end
    else
      @current_user = User.new
      @current_user.assign_attributes(Rails.configuration.default_user_attributes, :as => :guest)
      @current_user.creation_reason = "session"
      @current_user.role = "guest"
      @current_user.build_account
      @current_user.save!
      session[:user_id] = @current_user.id
      @current_user
    end
  end

  def create_user
  end
end
