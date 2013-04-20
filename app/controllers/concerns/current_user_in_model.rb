module CurrentUserInModel

  extend ActiveSupport::Concern

  included do
    around_action :set_current_user_in_model
  end

  private
  
  def set_current_user_in_model
    User.current_user = current_user
    yield
  ensure
    User.current_user = nil
  end

end
