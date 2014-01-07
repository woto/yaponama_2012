# encoding: utf-8
#
module BelongsToCreator
  extend ActiveSupport::Concern

  included do 
    belongs_to :creator, :class_name => "User"
    #validates :creator, presence: true
    before_validation :set_creator
  end

  def set_creator
    # TODO В какой-то момент появилось && User.current_user
    # (возможно когда работаю с почтой)
    # Попытаться заменить на JustBelon...
    if ( changes.present? || new_record? ) && User.current_user
      self.creator = User.current_user
    end
  end

end
