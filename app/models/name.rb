# encoding: utf-8
#
class Name < ActiveRecord::Base
  include HiddenRecreate
  include BelongsToProfile
  include BelongsToCreator
  include BelongsToSomebody
  include Transactionable
  include Selectable

  read_only :creation_reason

  has_many :orders

  belongs_to :profile, :inverse_of => :names
  validates :name, :presence => true

  def to_label
    "#{surname} #{name} #{patronymic}"
  end

end
