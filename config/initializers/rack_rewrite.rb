Rails.application.config.middleware.insert_before(Rack::Runtime, Rack::Rewrite) do
  #rewrite '/a1', '/accumulators?utf8=✓&name=&q[battery_capacity_gt]=30&q[battery_capacity_lt]=250&q[cold_cranking_amps_gt]=100&q[cold_cranking_amps_lt]=1000&q[length_gt]=0&q[length_lt]=600&q[width_gt]=0&q[width_lt]=300&q[height_gt]=80&q[height_lt]=300&commit=Обновить'
  #rewrite '/a2', '/accumulators?utf8=%E2%9C%93&name=&q%5Bbattery_capacity_gt%5D=30&q%5Bbattery_capacity_lt%5D=250&q%5Bcold_cranking_amps_gt%5D=100&q%5Bcold_cranking_amps_lt%5D=1000&q%5Blength_gt%5D=0&q%5Blength_lt%5D=600&q%5Bwidth_gt%5D=0&q%5Bwidth_lt%5D=300&q%5Bheight_gt%5D=80&q%5Bheight_lt%5D=300&commit=%D0%9E%D0%B1%D0%BD%D0%BE%D0%B2%D0%B8%D1%82%D1%8C'
  #r301 '/accumulators?utf8=✓&name=&q[battery_capacity_gt]=30&q[battery_capacity_lt]=250&q[cold_cranking_amps_gt]=100&q[cold_cranking_amps_lt]=1000&q[length_gt]=0&q[length_lt]=600&q[width_gt]=0&q[width_lt]=300&q[height_gt]=80&q[height_lt]=300&commit=Обновить', '/'
  #r301 '/accumulators?utf8=%E2%9C%93&name=&q%5Bbattery_capacity_gt%5D=30&q%5Bbattery_capacity_lt%5D=250&q%5Bcold_cranking_amps_gt%5D=100&q%5Bcold_cranking_amps_lt%5D=1000&q%5Blength_gt%5D=0&q%5Blength_lt%5D=600&q%5Bwidth_gt%5D=0&q%5Bwidth_lt%5D=300&q%5Bheight_gt%5D=80&q%5Bheight_lt%5D=300&commit=%D0%9E%D0%B1%D0%BD%D0%BE%D0%B2%D0%B8%D1%82%D1%8C', '/'
  r301 %r{^/user/products/new\?catalog_number=(.*)&manufacturer=(.*)&replacements=1}, '/user/products/new?catalog_number=$1&replacements=1'
  r301 %r{^/(.*)/$}, '/$1'
  r301 %r{^(/categories/.+)/brands$}, '$1'
  r301 %r{^/ru/parts/search/\?text=(.+)}, '/user/products/new?catalog_number=$1'
  r301 %r{^/ru/parts/search/(.+)}, '/user/products/new?catalog_number=$1'
  r301 %r{^/info/(.+)/(.+)}, '/user/products/new?catalog_number=$1'
  r301 %r{^/searches/(.+?)/.*}, '/user/products/new?catalog_number=$1'
  r301 %r{^/searches/(.+)\?}, '/user/products/new?catalog_number=$1'
  r301 %r{^/searches/(.+)}, '/user/products/new?catalog_number=$1'
  r301 %r{.*}, Proc.new {|path, rack_env| "http://www.#{rack_env['SERVER_NAME']}#{path}"}, :if => Proc.new {|rack_env|
    (rack_env['SERVER_NAME'][0...3] != 'www' && ENV['RACK_ENV'] == "production") &&
    !(['localhost', '127.0.0.1', '192.168.0.253'].include?(rack_env['SERVER_NAME']))
  }
end
