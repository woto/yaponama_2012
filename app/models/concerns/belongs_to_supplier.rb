module BelongsToSupplier
  extend ActiveSupport::Concern

  included do 
    # TODO Почему-то закомментировал validate в процессе
    belongs_to :supplier, touch: true, validate: true
    # TODO по идее можно заморочиться и прикрутить еще validates presence
  end

end
