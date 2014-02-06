# encoding: utf-8
#
module CachedProfile
  extend ActiveSupport::Concern

  included do

    before_save do
      if profile_id_changed?
        self.cached_profile_will_change!
      end
    end


    before_save do
      if cached_profile_changed?
        if profile
          cached_profile = {}
          Profile::FIELDS.each do |field|
            instance_eval <<-CODE, __FILE__, __LINE__ + 1
              cached_profile[field] = JSON.parse(profile.cached_#{field})
            CODE
          end
          self.cached_profile = cached_profile.to_json
        end
      end
    end

  end

end
