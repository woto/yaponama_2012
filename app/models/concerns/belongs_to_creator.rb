module BelongsToCreator
  extend ActiveSupport::Concern

  included do 
    belongs_to :creator, :class_name => "User", validate: true
    before_validation :set_creator
  end

  def set_creator
    if changes.present?
      self.creator = User.current_user
    end
  end

end
