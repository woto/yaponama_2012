module BelongsToUser
  extend ActiveSupport::Concern

  included do 
    # TODO validate?
    belongs_to :user, touch: true, validate: true
    validates :user, :presence => true
  end

end
