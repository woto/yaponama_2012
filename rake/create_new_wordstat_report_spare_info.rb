class CreateNewWordstatReportSpareInfo

  def self.create_new_wordstat_report_spare_info
    report_ids = Direct::Posters::Wordstat::GetWordstatReportList.new.post
    report_ids.each do |report_id|
      Direct::Posters::Wordstat::DeleteWordstatReport.new(report_id).post
    end

    loop do
      i = 0
      offset = 0
      limit = 10

      1.upto(5) do |i|
        phrases = SpareInfo.joins(:warehouses).where(shows: nil).order(:updated_at => :desc).limit(limit).offset(offset).pluck(:catalog_number)
        Direct::Posters::Wordstat::CreateNewWordstatReport.new(phrases).post
        offset += limit
      end

      i = 0
      begin
        i += 5
        sleep i
      end until (report_ids = Direct::Posters::Wordstat::GetWordstatReportList.new.post).size == 5

      report_ids.each do |report_id|
        reports = Direct::Posters::Wordstat::GetWordstatReport.new(report_id).post
        reports.each do |report|
          spare_info = SpareInfo.find_by(catalog_number: report['Phrase'])
          report['SearchedWith'].each do |keyword| 
            if keyword['Phrase'] == report['Phrase']
              spare_info.update!(shows: keyword['Shows'])
            end
          end
        end
        Direct::Posters::Wordstat::DeleteWordstatReport.new(report_id).post
      end

    end
  end
end
