module Direct::Responsers::Client
  class GetClientsUnits
    def parse(response)
      JSON.parse(response)['data'][0]['UnitsRest']
    end
  end
end
