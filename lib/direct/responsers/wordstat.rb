module Direct::Responsers::Wordstat
  class GetWordstatReportList < Direct::Responsers::Base
    def parse(response)
      super
      @response['data'].map{|item| item['ReportID'] if item['StatusReport'] == 'Done' }.compact
    end
  end

  class CreateNewWordstatReport < Direct::Responsers::Base
    def parse(response)
      super
      @response['data']
    end
  end

  class GetWordstatReport < Direct::Responsers::Base
    def parse(response)
      super
      @response['data']
    end
  end

  class DeleteWordstatReport < Direct::Responsers::Base
    def parse(response)
      super
      @response['data']
    end
  end
end
