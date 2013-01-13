class Stat < ActiveRecord::Base
  belongs_to :user
  attr_accessible :brs_time, :geo_city, :geo_country, :geo_district, :geo_lat, :geo_lng, :geo_region, :req_accept, :req_accepts, :req_base_url, :req_fullpath, :req_ip, :req_original_fullpath, :req_original_url, :req_path, :req_referer, :req_referrer, :req_remote_addr, :req_remote_ip, :req_request_method, :req_scheme, :req_url, :req_user_agent
end
