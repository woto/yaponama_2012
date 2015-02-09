class Direct::Builders::Base
  def initialize
    @json = Jbuilder.new
    @json.encode do |json|
      json.token '1598eb0b16cf44feafe6088b34a375ac'
      json.method self.class.name.demodulize
      json.locale 'ru'
    end
  end

  def to_builder
    @json.encode{}
  end
end
