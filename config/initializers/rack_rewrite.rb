Rails.application.config.middleware.insert_before(Rack::Runtime, Rack::Rewrite) do
  r301 %r{^/(.*)/$}, '/$1'
  r301 %r{^/ru/parts/search/\?text=(.+)}, '/user/products/new?catalog_number=$1'
  r301 %r{^/ru/parts/search/(.+)}, '/user/products/new?catalog_number=$1'
end
