# encoding: utf-8
#
Dir[File.join("#{Rails.root}", "system", "scripts", "auto.ru", "bmw")].each do |path|
  name = File.basename(path)
  if name != 'script.rb'
    content = File.read(path)
    b = Brand.where(name: name.upcase).first
    b = Brand.create!(name: name.upcase, phantom: false) unless b.present?
    parsed = JSON.parse(content)
    parsed.each do |line|
      m = b.models.where(name: line['model']).first
      m = b.models.create!(name: line['model'], phantom: false) unless m.present?
      line['generations'].each do |generation|
        g = m.generations.where(name: generation[1]).first
        g = m.generations.create!(name: generation[1], phantom: false) unless g.present?
      end
    end
  end
end
