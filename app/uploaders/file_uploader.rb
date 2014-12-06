class FileUploader < ApplicationUploader

  before :cache, :save_file_name

  def save_file_name(file)
      model.file_name ||= file.original_filename if file.respond_to?(:original_filename)
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
