class Direct::Posters::Base
  def post
    puts @body
    uri = URI.parse('https://api-sandbox.direct.yandex.ru/v4/json/')
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    req = Net::HTTP::Post.new(uri.path, 'Content-Type' =>'application/json')
    req.body = @body
    response = http.start {|http| http.request(req) }
    #puts "Response #{response.code} #{response.message}: #{response.body}"
    a = self.class.name.deconstantize.demodulize
    b = self.class.name.demodulize
    "Direct::Responsers::#{a}::#{b}".constantize.new.parse response.body
  end
end
