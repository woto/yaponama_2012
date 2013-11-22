# encoding: utf-8
#
module Selectable
  extend ActiveSupport::Concern

  included do

    def self.selected(item_ids)
      ids = item_ids && item_ids.select { |key, value| value == '1'}.keys
      if ids.any?
        where("#{self.name.tableize}.id IN (?)", ids).limit(1000).offset(0)
      else
        none
      end
    end

  end

end
