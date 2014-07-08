# encoding: utf-8
#
class Talk < ActiveRecord::Base
  include BelongsToSomebody
  include JustBelongsToCreator
  #include ConfirmRequired
  #include ControllerAction

  #def parent
  #  user
  #end

  mount_uploader :file, FileUploader

  validates :text, presence: true, if: -> { file.blank? }
  validates :file, presence: true, if: -> { text.blank? }

  accepts_nested_attributes_for :somebody

  before_save do
    # Это новая запись
    unless persisted?
      User.update_counters somebody.id, total_talks: 1, unread_talks: 1
    end

    if read_changed?
      if read_change[0] == false && read_change[1] == true
        User.decrement_counter :unread_talks, somebody.id
      elsif read_change[0] == true && read_change[1] == false
        User.increment_counter :unread_talks, somebody.id
      end
    end

  end

end
