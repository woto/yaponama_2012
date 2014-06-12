module ErrorHandling
  extend ActiveSupport::Concern

  included do

    skip_before_action :find_resource, only: [:render_404, :render_500]

    unless Rails.application.config.consider_all_requests_local
      rescue_from Exception, :with => :render_500
      rescue_from ActionController::RoutingError, :with => :render_404
      rescue_from ActionController::UnknownController, :with => :render_404
      rescue_from ActiveRecord::RecordNotFound, :with => :render_500
      rescue_from AuthenticationError, with: -> { redirect_to root_path, danger: "Возможно вы или кто-то другой входил на сайт под вашей учетной записью с другого компьютера. Вы можете отключить функцию автоматического выхода в Личном кабинете для возможности одновременной работы с разных компьютеров." }
    end

  end

  # TODO потом детальнее посмотреть где и как используются @exception
  def render_404(exception=nil)
    @exception = exception
    Rails.logger.error(exception)
    respond_to do |format|
    format.html { render 'error_404', :status => 404 }
    end
  end

  def render_500(exception=nil)
    @exception = exception
    Rails.logger.error(exception)
    respond_to do |format|
    format.html { render 'error_500', :status => 500 }
    end
  end

end
