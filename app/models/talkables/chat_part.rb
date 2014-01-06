class Talkables::ChatPart < ActiveRecord::Base
  include HiddenRecreate

  belongs_to :chat
  belongs_to :chat_partable, polymorphic: true
  accepts_nested_attributes_for :chat_partable

  def build_chat_partable(args)
    # TODO Почему этого нет в Rails? В чем подвох?
    self.chat_partable = chat_partable_type.constantize.new(args)
  end

end
