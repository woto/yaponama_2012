require 'rubygems'
require 'sitemap_generator'
#require 'net/http'
#require 'csv'

SitemapGenerator::Sitemap.default_host = "http://www.#{Rails.configuration.site['host']}/"

SitemapGenerator::Sitemap.create do

  0.times do
    add_to_index sitemap.sitemaps_namer.to_s
    sitemap.sitemaps_namer.next
  end

  Page.all.each do |page|
    add "/#{page.path}", :changefreq => 'monthly'
  end

  SpareInfo.all.each do |spare_info|
    add "/user/products/new?catalog_number=#{spare_info.catalog_number}", :changefreq => 'weekly'
  end

end
