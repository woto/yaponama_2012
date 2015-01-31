# encoding: utf-8
#
module ModelAttributes

  extend ActiveSupport::Concern

  included do

    belongs_to :model
    accepts_nested_attributes_for :model

    def model_attributes=(attr)
      #binding.pry
      if attr["name"].present? && brand.present?
        model = brand.models.where(name: attr["name"]).first
        if model.present?
          self.model = model
        else
          self.model = brand.models.build(name: attr["name"], phantom: true)
        end
      else
        self.model = nil
      end

    end

  end

end
