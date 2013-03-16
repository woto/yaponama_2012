class Comment < ActiveRecord::Base
  has_ancestry

  belongs_to :commentable, :polymorphic => true

  validates :content, presence: true
  validates :user, presence: true

  before_save :set_relation_object

  def set_relation_object
    self.commentable = root.commentable
  end

end
