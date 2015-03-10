class SpareInfoJob < ActiveJob::Base
  queue_as :default

  def perform(spare_info, spare_catalog, catalog_numbers, titles, min_days, min_cost, offers)
    spare_catalog =  Defaults.spare_catalog if spare_catalog.nil?
    spare_info.assign_attributes(spare_catalog: spare_catalog, titles: titles, min_days: min_days, min_cost: min_cost, offers: offers, aggregated_content_updated_at: Time.zone.now)
    catalog_numbers.unshift(spare_info.catalog_number)
    catalog_numbers.each do |catalog_number|
      spare_info.spare_info_phrases.find_or_initialize_by(catalog_number: catalog_number)
    end
    spare_info.save!
  end
end

#where("spare_info_phrases.name ~ '^[[:alnum:][:space:]\\.\\\-]+$'").
