module Users::Concerns::ExistingUser
  extend ActiveSupport::Concern

  included do

    def existing_user
      User.transaction do
        registered_user = current_user
        if registered_user
          registered_user.update_column(:role, User.roles['user'])
          guest_user.move_to(registered_user)
          guest_user.reload.destroy!
          session.delete(:guest_user_id)
        end
      end
    end
  end
end
