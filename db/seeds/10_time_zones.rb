# encoding: utf-8

time_zones = [
  ['Калининградское время	–1', 3, 0], 
  ['Московское время 0', 4, 0], 
  ['Екатеринбургское время +2', 6, 0], 
  ['Омское время +3', 7, 0], 
  ['Красноярское время +4', 8, 0],
  ['Иркутское время +5', 9, 0], 
  ['Якутское время +6', 10, 0], 
  ['Владивостокское время +7', 11, 0], 
  ['Магаданское время	+8', 12, 0]
]

time_zones.each do |time_zone, utc_offset_hours, utc_offset_minutes|
  TimeZone.create(:time_zone => time_zone, :utc_offset_hours => utc_offset_hours, :utc_offset_minutes => utc_offset_minutes)
end
