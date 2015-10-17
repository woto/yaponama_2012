class User::DiscourseController < ApplicationController
  def sso
    secret = Rails.application.secrets.discourse_secret
    sso = SingleSignOn.parse(request.query_string, secret)
    sso.email = current_user.email
    sso.name = current_user.name
    sso.username = current_user.name
    sso.external_id = current_user.id
    sso.sso_secret = secret

    redirect_to sso.to_url("http://#{Rails.configuration.discourse['host']}:#{Rails.configuration.discourse['port']}/session/sso_login") and return
  end
end
