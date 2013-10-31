module MobileField

  extend ActiveSupport::Concern

  included do 

    define_attribute_methods :mobile

    TRUE_VALUES = [true, 1, '1', 't', 'T', 'true', 'TRUE', 'on', 'ON'].to_set

    def value_to_boolean(value)
      if value.is_a?(String) && value.empty?
        nil
      else
        TRUE_VALUES.include?(value)
      end
    end

    def mobile
      @mobile
    end

    def mobile=(val)
      bool_val = value_to_boolean(val)
      mobile_will_change! unless bool_val == @mobile
      @mobile = bool_val
    end

    # В принципе это не надо, но для пущего эффекта
    def save
      @previously_changed = changes
      @changed_attributes.clear
    end

  end

end
