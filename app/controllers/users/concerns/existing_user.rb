module Users::Concerns::ExistingUser
  extend ActiveSupport::Concern

  included do

    def existing_user(user)
      User.transaction do
        if user.persisted?
          guest_user.move_to(user)
          guest_user.reload.destroy!
          session.delete(:guest_user_id)
        end
      end
    end
  end
end
