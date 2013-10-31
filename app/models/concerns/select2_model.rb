module Select2Model

  extend ActiveSupport::Concern

  included do

    def select2_model=(val)
      byebug
      if( a = Model.where(name: val.upcase).first ).present?
        write_attribute(:model_id, a.id)
      else
        create_model(name: val.upcase, phantom: true)
      end
    end


    def select2_model
      if(tmp = read_attribute(:model_id)).present?
        Model.find(tmp).to_label

      end
    end

  end

end
