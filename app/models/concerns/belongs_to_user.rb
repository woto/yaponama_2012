module BelongsToUser
  extend ActiveSupport::Concern

  included do 
    belongs_to :user, validate: true, touch: :activity_at
    validates :user, :presence => true
  end

end
