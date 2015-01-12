module Direct::Builders::Wordstat
  class CreateNewWordstatReport < Direct::Builders::Base
    attr_accessor :geo_ids, :phrases

    def initialize(phrases)
      super()
      @phrases = phrases
    end

    def to_builder
      @json.encode do |json|
        json.param do |param|
          param.Phrases do |phrase|
            phrase.array! @phrases
          end
          param.GeoID do |geo_id|
            geo_id.array! [213]
          end
        end
      end
    end
  end

  class GetWordstatReportList < Direct::Builders::Base
  end

  class DeleteWordstatReport < Direct::Builders::Base
    attr_accessor :report_id
    
    def initialize(report_id)
      super()
      @report_id = report_id
    end

    def to_builder
      @json.encode do |json|
        json.param @report_id
      end
    end
  end

  class GetWordstatReport < Direct::Builders::Base
    attr_accessor :report_id
    
    def initialize(report_id)
      super()
      @report_id = report_id
    end

    def to_builder
      @json.encode do |json|
        json.param @report_id
      end
    end
  end
end
