# encoding: utf-8
#
module Tokenable
  extend ActiveSupport::Concern

  included do

    # Railscasts 274

    def generate_token(column, version)
      begin
        case version
        when :long
          self[column] = SecureRandom.urlsafe_base64
        when :short
          self[column] = SecureRandom.hex[0...4]
        end
      end while self.class.exists?(column => self[column])
    end
 
  end

end
