module BelongsToCreator

  def self.included(base)
    base.belongs_to :creator, :class_name => "User"

    base.instance_eval {
      before_validation :set_creator
    }
  end

  def set_creator
    if self.changes.present?
      self.creator = User.current_user
    end
  end
end
