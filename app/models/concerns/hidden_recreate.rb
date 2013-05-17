module HiddenRecreate
  extend ActiveSupport::Concern

  included do
    attr_accessor :hidden_recreate

    def hidden_recreate
      '1'
    end
  end
end
