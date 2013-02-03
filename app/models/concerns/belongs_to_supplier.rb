module BelongsToSupplier
  extend ActiveSupport::Concern

  included do 
    belongs_to :supplier, validate: true, touch: :activity_at
    # TODO по идее можно заморочиться и прикрутить еще validates presence
  end

end
