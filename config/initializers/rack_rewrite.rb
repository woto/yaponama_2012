Rails.application.config.middleware.insert_before(Rack::Runtime, Rack::Rewrite) do
  r301 %r{^/(.*)/$}, '/$1'
  r301 %r{^/ru/parts/search/(\w+)}, '/user/products/new?catalog_number=$1'
end
