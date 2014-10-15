require 'net/http'

class SpareCatalogWorker
  include Sidekiq::Worker

  def perform(catalog_number, manufacturer, name)
    #URI::HTTP.build(:host => Rails.application.config_for('application/price')['host'], :port => Rails.application.config_for('application/price')['port'].to_i, :path => '/spare_catalogs', :query => {'catalog_number' => catalog_number, 'manufacturer' => CGI::escape(manufacturer), 'name' => name}.to_query)
    uri = URI('http://' + Rails.application.config_for('application/price')['host'].to_s + ":" + Rails.application.config_for('application/price')['port'].to_s + '/spare_catalogs')
    res = Net::HTTP.post_form(uri, 'catalog_number' => catalog_number, 'manufacturer' => manufacturer, 'name' => name)
    puts catalog_number, manufacturer, name
    raise 'NOT OK' unless res.body == 'ok'
  end
end
