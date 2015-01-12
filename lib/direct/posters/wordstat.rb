module Direct::Posters::Wordstat

  class GetWordstatReportList < Direct::Posters::Base
    def initialize
      @body = Direct::Builders::Wordstat::GetWordstatReportList.new.to_builder.to_json
    end
  end

  class CreateNewWordstatReport < Direct::Posters::Base
    def initialize(phrases)
      @body = Direct::Builders::Wordstat::CreateNewWordstatReport.new(phrases).to_builder.to_json
    end
  end

  class GetWordstatReport < Direct::Posters::Base
    def initialize(report_id)
      @body = Direct::Builders::Wordstat::GetWordstatReport.new(report_id).to_builder.to_json
    end
  end

  class DeleteWordstatReport < Direct::Posters::Base
    def initialize(report_id)
      @body = Direct::Builders::Wordstat::DeleteWordstatReport.new(report_id).to_builder.to_json
    end
  end

end
