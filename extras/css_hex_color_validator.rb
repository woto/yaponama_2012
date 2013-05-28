# encoding: utf-8

class CssHexColorValidator < ActiveModel::EachValidator

  def validate_each(object, attribute, value)
    unless value =~ /^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$/i
      object.errors[attribute] << (options[:message] || "Указан не правильный HEX код цвета. Подробнее ищите в интернете.")
    end
  end

end
