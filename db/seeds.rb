# encoding: utf-8

Dir[File.join(Rails.root, 'db', 'seeds', '*.rb')].sort.each { |seed| load seed }
Ckpages::Part.create(title: 'specialization', text: '')
