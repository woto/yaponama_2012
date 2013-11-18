# encoding: utf-8
#
class Talk < ActiveRecord::Base
  include BelongsToSomebody
  include BelongsToCreator
  #include ConfirmRequired
  #include ControllerAction

  #def parent
  #  user
  #end

  belongs_to :talkable, polymorphic: true, :dependent => :destroy
  accepts_nested_attributes_for :talkable

  accepts_nested_attributes_for :somebody

  def build_talkable(args)
    # TODO Почему этого нет в Rails? В чем подвох?
    self.talkable = talkable_type.constantize.new(args)
  end


  include Code_1AttrAccessorAndValidation

  before_validation on: :create do
    somebody.code_1 = code_1
    somebody.role = 'user'
  end

  include SetCreationReasonBasedOnCode_1


end
