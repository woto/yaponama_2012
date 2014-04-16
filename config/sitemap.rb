require 'rubygems'
require 'sitemap_generator'
require 'net/http'
require 'csv'

SitemapGenerator::Sitemap.default_host = "http://#{SiteConfig.site_address}/"

SitemapGenerator::Sitemap.create do

  0.times do
    add_to_index sitemap.sitemaps_namer.to_s
    sitemap.sitemaps_namer.next
  end

  #add '/searches', :changefreq => 'daily'
  #add '/contacts', :changefreq => 'weekly'

  Page.all.each do |page|
    add "/#{page.path}", :changefreq => 'monthly'
  end


  # Прайсы
  
  Net::HTTP.start(SiteConfig.price_address, SiteConfig.price_port) do |http|
    prices_urls = [
      '/suppliers/156/price_settings/263/download',
      '/suppliers/156/price_settings/264/download',
      '/suppliers/157/price_settings/265/download',
      '/suppliers/67/price_settings/106/download',
      '/suppliers/67/price_settings/139/download',
      #'/suppliers/67/price_settings/135/download',
    ]

    prices_urls.each do |price_url|
      resp = http.get(price_url)
      CSV.parse(resp.body) do |row|
        add "/user/products/new?catalog_number=#{row[1]}", :changefreq => 'weekly'
      end
    end

  end

end
