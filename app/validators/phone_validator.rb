# encoding: utf-8

class PhoneValidator < ActiveModel::EachValidator

  def validate_each(object, attribute, value)

    if object.errors[:value].blank?

      unless [true, false].include? object.mobile
        object.errors[attribute] << (options[:message] || "имеет непредусмотренное значение")
      end

      if object.mobile
        unless value =~ /\+7 \([0-9]{3}\) [0-9]{3}-[0-9]{2}-[0-9]{2}/
          object.errors[attribute] << (options[:message] || "имеет неверное значение")
        end
      end

    end

  end

end
