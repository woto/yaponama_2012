# encoding: utf-8
#
module BelongsToProfile
  extend ActiveSupport::Concern

  included do
    validates :profile, presence: true#, associated: true
    
    before_save :copy_somebody_id_from_profile_to_self

    def copy_somebody_id_from_profile_to_self
      self.somebody_id = profile.somebody_id
    end

  end

end
