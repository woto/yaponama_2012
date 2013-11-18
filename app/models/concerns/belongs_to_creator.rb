# encoding: utf-8
#
module BelongsToCreator
  extend ActiveSupport::Concern

  included do 
    belongs_to :creator, :class_name => "User"
    before_validation :set_creator
  end

  def set_creator
    if changes.present? || new_record?
      self.creator = User.current_user
    end
  end

end
