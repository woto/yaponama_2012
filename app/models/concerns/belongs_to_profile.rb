module BelongsToProfile
  extend ActiveSupport::Concern

  included do
    validates :profile, presence: true, associated: true
    
    before_save :copy_user_id_from_profile_to_self

    def copy_user_id_from_profile_to_self
      self.user_id = profile.user_id
    end

  end

end
