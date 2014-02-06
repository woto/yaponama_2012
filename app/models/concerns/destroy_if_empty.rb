# encoding: utf-8
#
module DestroyIfEmpty
  extend ActiveSupport::Concern

  included do

    before_validation do
      if persisted? && value.blank?
        self.mark_for_destruction
        #self.destroy
      end
    end

  end

end
