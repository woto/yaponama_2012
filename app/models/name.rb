# encoding: utf-8
#
class Name < ActiveRecord::Base
  include HiddenRecreate
  include BelongsToProfile
  include BelongsToCreator
  include BelongsToSomebody
  include Transactionable
  include Selectable
  #include RegisterCreationReason

  has_many :orders

  belongs_to :profile, :inverse_of => :names
  validates :name, :presence => true

  def to_label
    "#{surname} #{name} #{patronymic}"
  end

  include RenameMeConcernTwo

end
