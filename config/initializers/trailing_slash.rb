Rails.application.config.middleware.insert_before(Rack::Lock, Rack::Rewrite) do
  r301 %r{^/(.*)/$}, '/$1'
end
