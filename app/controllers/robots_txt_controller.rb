class RobotsTxtController < ApplicationController
  def index
    render :text => <<EOF
User-Agent: *
Allow: /
Crawl-delay: 5
Sitemap: http://#{SiteConfig.site_address}/sitemap_index.xml.gz
Host: #{SiteConfig.site_address}
EOF
  end
end
