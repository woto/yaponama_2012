module Selectable
  extend ActiveSupport::Concern

  included do

    def self.selected(item_ids)
      if item_ids.any?
        ids = item_ids.select { |key, value| value == '1'}.keys
        where('id IN (?)', ids).limit(1000).offset(0)
      else
        none
      end
    end

  end

end
