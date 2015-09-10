class ApplicationController < ActionController::Base

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :stats, if: -> {request.get? && current_user}

  include Concerns::Resource
  include Concerns::Actions
  include Zone
  include ErrorHandling
  include Concerns::Discourse
  include Concerns::Controllers::Authentication

  add_flash_types :success, :info, :warning, :danger

  private

  def stats
    remote_ip = request.remote_ip

    if current_user.current_sign_in_ip != remote_ip
      res = Ipgeobase::find_region_by_ip(remote_ip)
      current_user.current_sign_in_ip = remote_ip
      current_user.ipgeobase_name = res && res.name || ''
      current_user.ipgeobase_names_depth_cache = res && res.names_depth_cache || ''
    end

    current_user.user_agent = request.user_agent.to_s
    current_user.accept_language = request.accept_language.to_s
    current_user.location = request.protocol + request.host_with_port + request.original_fullpath
    current_user.referrer = request.referer
    current_user.first_referrer = request.referer if current_user.first_referrer.nil?
    current_user.time_zone = cookies['browser.timezone']

    current_user.save!
  end

end
