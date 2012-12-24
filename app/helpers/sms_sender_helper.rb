#encoding: utf-8

module SmsSenderHelper       

  def notify(data)
    unless data[:destination_address]
      raise 'Не указан телефон получателя SMS destination_address. Для Российских сотовых например "+71112223344"'
    end

    unless data[:message_data]
      raise 'Не указан текст сообщения message_data'
    end

    case Rails.configuration.avisosms[:method]
    when 'sms'
      SmsSender.notify_by_sms data
    when 'growl'
      SmsSender.notify_by_growl data
    when 'flash'
      flash[:notice] = "На номер #{data[:destination_address]} отправлено сообщение с текстом \"#{data[:message_data]}\". В демонстрационной версии отправка SMS не производится."
    else 
      raise 'Указан несуществующий способ отправки уведомления. Полный список в конфиге.'
    end
  end
  
end
