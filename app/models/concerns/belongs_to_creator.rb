module BelongsToCreator
  extend ActiveSupport::Concern

  included do 
    belongs_to :creator, :class_name => "User"
  end

end
