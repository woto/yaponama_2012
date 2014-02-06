# encoding: utf-8
#
module RenameMeConcernFour

  extend ActiveSupport::Concern

  included do

    def old_postal_address_id
      @old_postal_address_id
    end

    def old_postal_address_id=(id)
      if id.present?
        @old_postal_address_id = id.to_i
      end
    end

    def old_postal_address
      @old_postal_address ||= PostalAddress.find(old_postal_address_id) rescue nil
    end

    def old_postal_address=(postal_address)
      @old_postal_address = postal_address
    end

    def old_postal_address_attributes=(attr)
      old_postal_address.assign_attributes(attr)
    end

    def new_postal_address=(postal_address)
      @new_postal_address = postal_address
    end

    def new_postal_address
      @new_postal_address
    end

    def new_postal_address_attributes=(attr)
      self.new_postal_address = PostalAddress.new(attr)
    end

    before_validation do
      if postal_address_type == 'new' && new_postal_address
        self.postal_address = new_postal_address
      elsif postal_address_type == 'old' && old_postal_address
        self.postal_address = old_postal_address
        #self.postal_address_id = old_postal_address_id
      end
    end

  end

end
