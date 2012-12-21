module CurrentUserInModel

  def self.included(base)
    base.instance_eval{
      around_filter :set_current_user_in_model
    }
  end
  
  def set_current_user_in_model
    User.current_user = current_user
    yield
  ensure
    User.current_user = nil
  end

end
