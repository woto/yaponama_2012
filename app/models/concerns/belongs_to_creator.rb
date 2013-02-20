module BelongsToCreator
  extend ActiveSupport::Concern

  included do 
    # CHECK validate: true - не нужна, запретить возможность выставления из params при post например
    belongs_to :creator, :class_name => "User"
    before_validation :set_creator
  end

  def set_creator
    if changes.present?
      self.creator = User.current_user
    end
  end

end
