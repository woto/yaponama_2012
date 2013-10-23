module ModificationAttributes

  extend ActiveSupport::Concern

  included do

    belongs_to :modification
    accepts_nested_attributes_for :modification
    #validates :modification, associated: true

    def modification_attributes=(attr)
      if attr["name"].present? && generation.present?
        modification = generation.modifications.where(name: attr["name"]).first
        if modification.present?
          self.modification = modification
        else
          self.modification = generation.modifications.build(name: attr["name"], phantom: true)
        end
      else
        self.modification = nil
      end

      #self.modification_id_will_change!

    end

  end

end