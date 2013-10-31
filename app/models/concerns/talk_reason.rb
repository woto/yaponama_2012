module TalkReason
  extend ActiveSupport::Concern

  included do
    attr_accessor :reason

    before_validation if: -> { controller == 'talks' } do
      self.reason = 'talk'
      self.creation_reason = 'talk'
    end

  end

end
