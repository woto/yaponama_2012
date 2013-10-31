module GenerationAttributes

  extend ActiveSupport::Concern

  included do

    belongs_to :generation
    accepts_nested_attributes_for :generation

    def generation_attributes=(attr)
      if attr["name"].present? && model.present?
        generation = model.generations.where(name: attr["name"]).first
        if generation.present?
          self.generation = generation
        else
          self.generation = model.generations.build(name: attr["name"], phantom: true)
        end
      else
        self.generation = nil
      end

    end

  end

end
