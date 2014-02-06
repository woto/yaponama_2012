# encoding: utf-8
#
module RenameMeConcernThree

  extend ActiveSupport::Concern

  included do

    def old_profile_id
      @old_profile_id
    end

    def old_profile_id=(id)
      if id.present?
        @old_profile_id = id.to_i
      end
    end

    def old_profile
      @old_profile ||= Profile.find(old_profile_id) rescue nil
    end

    def old_profile=(profile)
      @old_profile = profile
    end

    def old_profile_attributes=(attr)
      old_profile.assign_attributes(attr)
    end

    def new_profile=(profile)
      @new_profile = profile
    end

    def new_profile
      @new_profile
    end

    def new_profile_attributes=(attr)
      self.new_profile = Profile.new(attr)
    end

    before_validation do
      #binding.pry
      if profile_type == 'new' && new_profile
        self.profile = new_profile
      elsif profile_type == 'old' && old_profile
        self.profile = old_profile
        #self.profile_id = old_profile_id
      end
    end

  end

end
