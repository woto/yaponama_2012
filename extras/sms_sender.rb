class SmsSender

  class <<  self

    def notify_by_growl data
      g = Growl.new "127.0.0.1", "ruby-growl", nil
      g.add_notification('ruby-growl Notification')
      g.notify 'ruby-growl Notification', data[:destination_address] , data[:message_data]
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
        response = http.request(req)
      
        if( (status = Hash.from_xml(response.body)["Envelope"]["Body"]["SendTextMessageResponse"]["SendTextMessageResult"]) != 'OK_Operation_Completed')
          raise status
        end
      
      end
    end

    handle_asynchronously :notify_by_sms  

  end

end
