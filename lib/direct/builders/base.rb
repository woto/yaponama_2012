class Direct::Builders::Base
  def initialize
    @json = Jbuilder.new
    @json.encode do |json|
      json.token '26a546d8b348448384dcde1cc11fb135'
      json.method self.class.name.demodulize
      json.locale 'ru'
    end
  end

  def to_builder
    @json.encode{}
  end
end
