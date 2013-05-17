#encoding: utf-8

class Name < ActiveRecord::Base
  include HiddenRecreate
  include BelongsToProfile
  include BelongsToCreator
  include BelongsToUser
  include Transactionable

  has_many :orders

  belongs_to :profile, :inverse_of => :names
  validates :name, :presence => true

  # TODO убрать везде валидацию и запретить выставление в ..._params (т.к. меняться руками никем не будет)
  validates :creation_reason, :presence => true, :inclusion => { :in => Rails.configuration.user_name_creation_reason.keys }

  def to_label
    name
  end

end
