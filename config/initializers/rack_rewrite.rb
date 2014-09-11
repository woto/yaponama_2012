Rails.application.config.middleware.insert_before(Rack::Runtime, Rack::Rewrite) do
  r301 %r{^/(.*)/$}, '/$1'
  r301 %r{^/ru/parts/search/\?text=(.+)}, '/user/products/new?catalog_number=$1'
  r301 %r{^/ru/parts/search/(.+)}, '/user/products/new?catalog_number=$1'
  r301 %r{^/info/(.+)/(.+)}, '/user/products/new?catalog_number=$1'
  r301 %r{^/searches/(.+?)/.*}, '/user/products/new?catalog_number=$1'
  r301 %r{^/searches/(.+)\?}, '/user/products/new?catalog_number=$1'
  r301 %r{^/searches/(.+)}, '/user/products/new?catalog_number=$1'
  r301 %r{.*}, Proc.new {|path, rack_env| "http://www.#{rack_env['SERVER_NAME']}#{path}"}, :if => Proc.new {|rack_env|
    (rack_env['SERVER_NAME'][0...3] != 'www' && ENV['RACK_ENV'] == "production") &&
    !(['localhost', '127.0.0.1', '192.168.0.254'].include?(rack_env['SERVER_NAME']))
  }
end
