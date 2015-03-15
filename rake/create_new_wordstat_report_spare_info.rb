class CreateNewWordstatReportSpareInfo

  def self.create_new_wordstat_report_spare_info

    #debug_counter = 0

    report_ids = YandexDirect.new(:GetWordstatReportList).send.done_reports
    report_ids.each do |report_id|
      YandexDirect.new(:DeleteWordstatReport, {:param => report_id}).send
    end

    loop do
      offset = 0
      limit = 10

      1.upto(5) do |i|
        phrases = SpareInfoPhrase.
          joins(:spare_info).
          where("min_cost > ?", 500).
          where("min_cost < ?", 15000).
          where(:yandex_shows => nil).
          where(:publish => nil).
          where("LENGTH(phrase) >= ?", 10).
          limit(limit).
          offset(offset).
          pluck(:phrase)

        #debug_counter += phrases.count
        #puts 'debug_counter'
        #puts debug_counter

        YandexDirect.new(:CreateNewWordstatReport, {:param => {"Phrases" => phrases}}).send
        offset += limit
      end

      i = 0
      begin
        i += 5
        sleep i
      end until (report_ids = YandexDirect.new(:GetWordstatReportList).send.done_reports).size == 5

      report_ids.each do |report_id|
        reports = YandexDirect.new(:GetWordstatReport, {:param => report_id}).send.data
        reports.each do |report|
          spare_info_phrases = SpareInfoPhrase.where(:phrase => report['Phrase'])
          report['SearchedWith'].each do |keyword|
            if keyword['Phrase'] == report['Phrase']
              spare_info_phrases.each do |spare_info_phrase|
                spare_info_phrase.update!(:yandex_shows => keyword['Shows'], :yandex_wordstat_updated_at => Time.zone.now)
              end
            end
          end
        end
        YandexDirect.new(:DeleteWordstatReport, {:param => report_id}).send
      end

    end
  end
end
