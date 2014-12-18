class SpareReplacement < ActiveRecord::Base

  # new number - Новый номер производителя
  # old number - Старый номер производителя
  # same number - Абсолютно такая же деталь, только под другим номером
  enum status: Rails.configuration.replacements_statuses

  include FromSpareInfoAttributes
  include FromCachedSpareInfo
  include ToSpareInfoAttributes
  include ToCachedSpareInfo

  validates :from_spare_info, :to_spare_info, presence: true
  validates :from_spare_info, uniqueness: { scope: [:to_spare_info] }
  validates :status, presence: true
  validates :wrong, inclusion: {in: [false, true] }

  validate :to_spare_info do
    errors.add(:to_spare_info, 'Товары идентичны, выберите другой') if to_spare_info == from_spare_info
  end

  def to_label
    "#{from_cached_spare_info} - #{to_cached_spare_info}"
  end

end
