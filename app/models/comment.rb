# encoding: utf-8
#
class Comment < ActiveRecord::Base
  include BelongsToCreator
  has_ancestry

  belongs_to :commentable, :polymorphic => true

  validates :content, presence: true

  before_save :set_relation_object

  def set_relation_object
    self.commentable = root.commentable
  end

end
