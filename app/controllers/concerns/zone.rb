module Zone
  extend ActiveSupport::Concern
  included do
  helper_method :admin_zone?
  helper_method :public_zone?
  def admin_zone?
    params[:controller].partition('/').first == 'admin'
  end

  def public_zone?
    !admin_zone?
  end
  end
end
