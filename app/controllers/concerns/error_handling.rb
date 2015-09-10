module ErrorHandling
  extend ActiveSupport::Concern

  included do

    skip_before_action :find_resource, only: [:render_404, :render_500]

    if Rails.configuration.common['suppress_exceptions']
      #rescue_from Exception, :with => :render_500
      # Это более не актуально. Необходимо использовать config.exceptions_app ? или
      # wildcard match (*) как это сейчас в ckpages ? Или config.action_dispatch.rescue_responses ?
      # http://www.youtube.com/results?search_query=exception+railscasts
      #rescue_from ActionController::RoutingError, :with => :render_404
      #rescue_from ActionController::UnknownController, :with => :render_404
      #rescue_from ActiveRecord::RecordNotFound, :with => :render_500
      rescue_from AuthenticationError, with: ->(exception) { redirect_to main_app.root_path, alert: exception.message }
      rescue_from BanishError, with: ->(exception) { redirect_to 'http://example.com' }
      rescue_from Pundit::NotAuthorizedError, with: -> {redirect_to( (request.referrer || admin_root_path), alert: 'Недостаточно прав для данного действия')}
      #rescue_from ActionController::InvalidAuthenticityToken, :with => :render_500
    end

  end

  # TODO потом детальнее посмотреть где и как используются @exception
  def render_404(exception=nil)
    @exception = exception
    Rails.logger.error(exception)
    respond_to do |format|
      format.html { render 'error_404', :status => 404 }
      format.js { render js: "alert('Возникла непредвиденная ошибка на сайте #{Rails.configuration.site['host']}, поробуйте перезагрузить страницу или связаться с разработчиками сайта.');" }
    end
  end

  def render_500(exception=nil)
    @exception = exception
    Rails.logger.error(exception)
    respond_to do |format|
      format.html { render 'error_500', :status => 500 }
      format.js { render js: "alert('Возникла непредвиденная ошибка на сайте #{Rails.configuration.site['host']}, поробуйте перезагрузить страницу или связаться с разработчиками сайта.');" }
    end
  end

end
