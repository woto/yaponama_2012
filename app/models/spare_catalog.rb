class SpareCatalog < ActiveRecord::Base

  before_save do
    name = self.name.mb_chars
    content = self.name.mb_chars

    name = name.upcase
    content = content.upcase

    #name = name.gsub('Ё', 'Е')
    content = content.gsub('Ё', 'Е')

    content = content.gsub(/[^[:word:]\s]/, ' ')

    self.content = content
    self.name = name

  end

end
