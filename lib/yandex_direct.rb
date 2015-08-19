class YandexDirect

  LOGGER = Logger.new(Rails.root.join("log", "yandex_direct.log"))
  LOGGER.extend(ActiveSupport::Logger.broadcast(Logger.new(STDOUT)))

  attr_accessor :request, :response

  def initialize(*params)
    @request = (params[1] || {}).merge(
      "token" => Rails.application.secrets.yandex_direct_token,
      "method" => params[0],
      "locale" => 'ru'
    )
  end

  def send
    LOGGER.info "SEND: #{@request}"
    uri = URI.parse('https://api.direct.yandex.ru/live/v4/json/')
    http = Net::HTTP.new(uri.host, uri.port)
    http.read_timeout = 2400
    http.open_timeout = 2400
    http.use_ssl = true
    req = Net::HTTP::Post.new(uri.path, 'Content-Type' =>'application/json')
    req.body = @request.to_json
    @response = http.start {|h| h.request(req)}
    @response = @response.body
    @response = JSON.parse(@response)
    LOGGER.info "RECV: #{@response}"
    if @response.key? 'error_code'
      binding.pry
      raise 'EXIT'
    end
    self
  end

  def done_reports
    @response['data'].map{|item| item['ReportID'] if item['StatusReport'] == 'Done' }.compact
  end

  def data
    @response['data']
  end

end
