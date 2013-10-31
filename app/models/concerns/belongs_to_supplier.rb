module BelongsToSupplier
  extend ActiveSupport::Concern

  included do 
    belongs_to :supplier
  end

end
