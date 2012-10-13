# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Emanuel', :city => cities.first)

[
  ['Калининградское время	–1', 3, 0], 
  ['Московское время 0', 4, 0], 
  ['Екатеринбургское время +2', 6, 0], 
  ['Омское время +3', 7, 0], 
  ['Красноярское время +4', 8, 0],
  ['Иркутское время +5', 9, 0], 
  ['Якутское время +6', 10, 0], 
  ['Владивостокское время +7', 11, 0], 
  ['Магаданское время	+8', 12, 0]
].each do |time_zone, utc_offset_hours, utc_offset_minutes|
  TimeZone.create(:time_zone => time_zone, :utc_offset_hours => utc_offset_hours, :utc_offset_minutes => utc_offset_minutes)
end
