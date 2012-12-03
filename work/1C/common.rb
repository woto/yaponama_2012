module Common
  def self.file_check file
    if file.blank?
      puts 'Please specify a processed file'
      exit
    else
      unless File.exist?(file) && File.file?(file)
        puts 'Input filename is incorrect'
        exit
      end
    end
  end
end
