class Opts::Accumulator < ActiveRecord::Base
  belongs_to :spare_info
  has_many :warehouses, :through => :spare_info
  has_many :places, :through => :warehouses

  validates :spare_info, presence: true
end
