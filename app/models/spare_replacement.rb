class SpareReplacement < ActiveRecord::Base

  enum status: Rails.configuration.replacements_statuses

  include Concerns::FromSpareInfoAttributes
  include Concerns::ToSpareInfoAttributes

  validates :from_spare_info, :to_spare_info, presence: true
  validates :from_spare_info, uniqueness: { scope: [:to_spare_info, :status] }
  #validates :to_spare_info, uniqueness: { scope: [:from_spare_info, :status] }
  validates :status, presence: true
  validates :wrong, inclusion: {in: [false, true] }

  validate :to_spare_info do
    errors.add(:to_spare_info, 'Товары идентичны, выберите другой') if to_spare_info == from_spare_info
  end

  def to_label
    "#{from_spare_info.to_label} - #{to_spare_info.to_label}"
  end

  after_create do
    case status
      #when :new_number
      #when :old_number
      #when :same_number
      when :replacement
      #when :part_of
      #when :consists_of
    end
  end

end
