class SpareReplacement < ActiveRecord::Base
  include FromSpareInfoAttributes
  include FromCachedSpareInfo
  include ToSpareInfoAttributes
  include ToCachedSpareInfo


  validates :from_spare_info, :to_spare_info, presence: true

  validate :to_spare_info do
    errors.add(:to_spare_info, 'Товары идентичны, выберите другой') if to_spare_info == from_spare_info
  end

  def to_label
    "#{from_cached_spare_info} - #{to_cached_spare_info}"
  end

end
