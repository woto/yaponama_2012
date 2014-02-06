class ErrorController < ApplicationController

  def index
    raise ActionController::RoutingError.new("Страница #{request.original_url} не найдена")
  end

  private

  def set_resource_class
  end

end
