# encoding: utf-8
#
class Ipgeobase::Ip < ActiveRecord::Base

  self.table_name = "ipgeobase_ips"

  belongs_to :region, :primary_key => :region_id

  validates :start_ip, :presence => true
  validates :end_ip, :presence => true
  validates :region_id, :presence => true

end
