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

  before_validation do
    somebody.code_1 = code_1
  end

  belongs_to :addressee, class_name: "Somebody"

  belongs_to :talkable, polymorphic: true, :dependent => :destroy
  accepts_nested_attributes_for :talkable

  accepts_nested_attributes_for :somebody

  def build_talkable(args)
    # TODO Почему этого нет в Rails? В чем подвох?
    self.talkable = talkable_type.constantize.new(args)
  end

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

  include RenameMeConcern

  #######

  after_save do
    talk = ApplicationController.new.render_to_string(template: 'talks/show.html.erb', layout: false, locals: { resource: self })
    self.update_column(:cached_talk, talk)
    $redis.publish("#{Rails.env}:show talk", JSON.dump(self.as_json))
  end

end
