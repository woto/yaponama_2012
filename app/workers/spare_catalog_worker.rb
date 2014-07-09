require 'net/http'

class SpareCatalogWorker
  include Sidekiq::Worker

  def perform(catalog_number, manufacturer, name)
    uri = URI('http://' + CONFIG.site['host'] + ":" + CONFIG.site['port'] + '/spare_catalogs')
    res = Net::HTTP.post_form(uri, 'catalog_number' => catalog_number, 'manufacturer' => manufacturer, 'name' => name)
    puts catalog_number, manufacturer, name
  end
end
