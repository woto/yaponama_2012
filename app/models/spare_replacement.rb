class SpareReplacement < ActiveRecord::Base

  include Concerns::FromSpareInfoAttributes
  include Concerns::ToSpareInfoAttributes

  # new_num - левая устаревшая, правая новая
  # same_num - такая же деталь (для аккумуляторов и т.д.)
  # repl_num - замена с левой на правую
  # part_num - левая является частью правой

  enum status: ['new_num', 'same_num', 'repl_num', 'part_num']

  validates :from_spare_info, presence: true, uniqueness: { scope: [:to_spare_info] }
  validates :to_spare_info, presence: true, uniqueness: { scope: [:from_spare_info] }
  validates :status, presence: true
  validates :wrong, inclusion: {in: [false, true] }

  validate do
    errors.add(:base, 'товары идентичны, выберите другой') if to_spare_info == from_spare_info
  end

  validate if: -> {status.in? ['new_num', 'same_num', 'part_num'] } do
    if SpareReplacement.where(from_spare_info: to_spare_info, to_spare_info: from_spare_info).any?
      errors.add(:base, 'невозможно сохранить замену, т.к. существует дубликат')
    end
  end

  validate if: -> {status.in? ['repl_num']} do
    if SpareReplacement.where(from_spare_info: to_spare_info, to_spare_info: from_spare_info).where.not(status: SpareReplacement.statuses['repl_num']).any?
      errors.add(:base, 'невозможно сохранить замену, т.к. существует дубликат')
    end
  end

  def to_label
    "#{from_spare_info.to_label} - #{to_spare_info.to_label}"
  end

end
