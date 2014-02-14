require './../../../extras/template_data'
require 'rubygems'
require 'yandex_mystem'
require 'pathname'

TemplateData::SHORT_NAMES.each do |name|
  #stemmed = YandexMystem::Simple.stem(name).values.join(' ')
  stemmed = name
  SpareCatalog.create(:name => name, :content => stemmed)
end
