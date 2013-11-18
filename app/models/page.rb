# encoding: utf-8
#
class Page < ActiveRecord::Base
  include BelongsToCreator
  include Transactionable
  include Selectable
  include Code_1AttrAccessorAndValidation
  include SetCreationReasonBasedOnCode_1

  before_save :cut_first_slash

  validates :path, :presence => true, :uniqueness => {case_sensitive: false}

  has_and_belongs_to_many :uploads

  def cut_first_slash
    self.path = self.path.gsub(/^\/+/, '')
    if self.path.length <= 0
      errors.add(:path, "не может быть пустым.")
      return false
    end
  end

  has_many :comments, :as => :commentable

  def to_label
    path
  end

end
