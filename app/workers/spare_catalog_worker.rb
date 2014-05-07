require 'net/http'

class SpareCatalogWorker
  include Sidekiq::Worker

  def perform(catalog_number, manufacturer, name)
    uri = URI('http://' + SiteConfig.price_full_address + '/spare_catalogs')
    res = Net::HTTP.post_form(uri, 'catalog_number' => catalog_number, 'manufacturer' => manufacturer, 'name' => name)
    puts catalog_number, manufacturer, name
  end
end
