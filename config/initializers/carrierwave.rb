CarrierWave.configure do |config|
  config.asset_host = "http://#{CONFIG.site['host']}:#{CONFIG.site['port']}"
end

CarrierWave::SanitizedFile.sanitize_regexp = /[^[:word:]\.\-\+]/

# Для возможности создания файла из строки
# https://github.com/carrierwaveuploader/carrierwave/wiki/How-to%3A-Upload-from-a-string-in-Rails-3

class StringWithFileNameIO < StringIO
  attr_accessor :filepath

  def initialize(*args)
    super(*args[1..-1])
    @filepath = args[0]
  end

  def original_filename
    File.basename(filepath)
  end
end
