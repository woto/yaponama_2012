# encoding: utf-8
#
class Page < ActiveRecord::Base
  include BelongsToCreator
  include Transactionable
  include Selectable
  include Code_1AttrAccessorAndValidation
  include SetCreationReasonBasedOnCode_1

  # TODO разобраться почему это вызываю дважды
  before_save :normalize
  before_validation :normalize

  validates :path, presence: true, uniqueness: {case_sensitive: false}
  validates :redirect_url, uniqueness: {case_sensitive: false}
  validates :redirect_url, format: { with: /\A\/|http:\/\/|https:\/\// }

  has_and_belongs_to_many :uploads

  def normalize

    self.path = self.path.gsub(/\A\/+/, '')
    self.path = self.path.gsub(/\/+\z/, '')
    self.path = self.path.gsub(/\A\s+/, '')
    self.path = self.path.gsub(/\s+\z/, '')

    if self.path.length <= 0
      errors.add(:path, "не может быть пустым.")
      return false
    end
  end

  def to_label
    path
  end

end
