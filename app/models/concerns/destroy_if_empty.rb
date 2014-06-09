# encoding: utf-8
#
module DestroyIfEmpty
  extend ActiveSupport::Concern

  included do

    before_validation do
      
      #if persisted? && value.blank?
      if value.blank? && !(["register"].include?(code_1))
        self.mark_for_destruction
        #self.destroy
      end
    end

  end

end
