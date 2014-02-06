class Talkables::ChatPartables::File::FileUploader < CarrierWave::Uploader::Base

  before :cache, :save_title
  def save_title(file)
      model.title ||= file.original_filename if file.respond_to?(:original_filename)
  end

  def filename
     "#{secure_token}.#{file.extension}" if original_filename.present?
  end

  protected
  def secure_token
    var = :"@#{mounted_as}_secure_token"
    model.instance_variable_get(var) or model.instance_variable_set(var, SecureRandom.uuid)
  end

end
