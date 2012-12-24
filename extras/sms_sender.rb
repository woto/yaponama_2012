#encoding: utf-8

class SmsSender        
      
  class << self
    def notify(data)
      unless data[:destinationAddress]
        raise 'Не указан телефон получателя смс destinationAddress. Для Российских сотовых например "+71112223344"'
      end

      unless data[:messageData]
        raise 'Не указан текст сообщения messageData'
      end

      if Rails.configuration.avisosms[:send_sms]
        notify_by_sms data
      else 
        notify_by_growl data
      end
    end
    
    private
    
      def notify_by_growl data
        g = Growl.new "127.0.0.1", "ruby-growl", nil
        #phone = data[:destinationAddress].gsub(/^(\d{3})(\d{3})(\d{2})/, '+7 (\1) \2-\3-')
        g.add_notification('ruby-growl Notification')
        g.notify 'ruby-growl Notification', data[:destinationAddress] , data[:messageData]
      end
    
      def notify_by_sms data
        require 'net/http'
            
        Net::HTTP.start('sms.avisosms.ru') do |http| 
          req = Net::HTTP::Post.new('/gate.php')
          req.set_content_type('text/xml', { 'charset' => 'utf-8' })
          req.body = ApplicationController.new.send(:render_to_string,
                                          :partial => 'avisosms/send_sms_text.html', 
                                          :layout => false,
                                          :locals => { :data => data })
          req.add_field("SOAPAction", '"http://sms.avisosms.ru/gate.php"') 
          debugger
          response = http.request(req)
          debugger
        
          if( (status = Hash.from_xml(response.body)["Envelope"]["Body"]["SendTextMessageResponse"]["SendTextMessageResult"]) != 'OK_Operation_Completed')
            raise status
          end
        
        end
      end
    
      #handle_asynchronously :notify_by_sms  
  end
    
end
