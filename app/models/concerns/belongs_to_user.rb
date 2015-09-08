module BelongsToUser
  extend ActiveSupport::Concern

  included do 
    belongs_to :user, :class_name => "User"
  end

end
