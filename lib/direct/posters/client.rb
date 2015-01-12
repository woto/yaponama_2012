module Direct::Posters::Client
  class GetClientsUnits < Direct::Posters::Base
    def initialize
      @body = Direct::Builders::Client::GetClientsUnits.new.to_builder.to_json
    end
  end
end
