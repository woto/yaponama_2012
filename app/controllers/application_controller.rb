class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :create_user

  def create_user
    user = User.find_or_initialize_by_session_id(request.session_options[:id])
    user.creation_reason = "session"
    #user.ping = Ping.new
    user.save
  end

end
