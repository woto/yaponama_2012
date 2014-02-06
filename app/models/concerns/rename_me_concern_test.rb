# encoding: utf-8
#
module RenameMeConcernTest

  extend ActiveSupport::Concern

  included do

    def old_legal_address_id
      @old_legal_address_id
    end

    def old_legal_address_id=(id)
      if id.present?
        @old_legal_address_id = id.to_i
      end
    end

    def old_legal_address
      @old_legal_address ||= PostalAddress.find(old_legal_address_id) rescue nil
    end

    def old_legal_address=(legal_address)
      @old_legal_address = legal_address
    end

    def old_legal_address_attributes=(attr)
      old_legal_address.assign_attributes(attr)
    end

    def new_legal_address=(legal_address)
      @new_legal_address = legal_address
    end

    def new_legal_address
      @new_legal_address
    end

    def new_legal_address_attributes=(attr)
      self.new_legal_address = PostalAddress.new(attr)
    end

    before_validation do
      #binding.pry
      if legal_address_type == 'new' && new_legal_address
        self.legal_address = new_legal_address
      elsif legal_address_type == 'old' && old_legal_address
        self.legal_address = old_legal_address
        #self.legal_address_id = old_legal_address_id
      end
    end

    def old_actual_address_id
      @old_actual_address_id
    end

    def old_actual_address_id=(id)
      if id.present?
        @old_actual_address_id = id.to_i
      end
    end

    def old_actual_address
      @old_actual_address ||= PostalAddress.find(old_actual_address_id) rescue nil
    end

    def old_actual_address=(actual_address)
      @old_actual_address = actual_address
    end

    def old_actual_address_attributes=(attr)
      old_actual_address.assign_attributes(attr)
    end

    def new_actual_address=(actual_address)
      @new_actual_address = actual_address
    end

    def new_actual_address
      @new_actual_address
    end

    def new_actual_address_attributes=(attr)
      self.new_actual_address = PostalAddress.new(attr)
    end


    before_validation do
      #binding.pry
      if actual_address_type == 'new' && new_actual_address
        self.actual_address = new_actual_address
      elsif actual_address_type == 'old' && old_actual_address
        self.actual_address = old_actual_address
        #self.actual_address_id = old_actual_address_id
      end
    end

  end

end
