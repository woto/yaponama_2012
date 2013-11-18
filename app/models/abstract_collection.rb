# encoding: utf-8
#
class AbstractCollection

  include ActiveModel::Model
  include ActiveModel::Dirty
  include ActiveModel::Validations::Callbacks
  include ActiveModel::SecurePassword

  attr_accessor :items

  private

  def any_item
    errors.add(:base, 'Ни одна позиция не выделена.') if items.blank?
  end

end
