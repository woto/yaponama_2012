module BelongsToSomebody
  extend ActiveSupport::Concern

  included do 
    belongs_to :somebody, inverse_of: self.name.pluralize.underscore.to_sym
  end

end
