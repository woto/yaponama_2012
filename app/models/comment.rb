class Comment < ActiveRecord::Base
  attr_accessible :commentable_id, :commentable_type, :content, :parent_id, :as => [:admin, :manager, :user, :guest]
  has_ancestry

  belongs_to :user
  belongs_to :commentable, :polymorphic => true

  validates :content, presence: true
  validates :user, presence: true

  before_save :set_relation_object

  def set_relation_object
    self.commentable = root.commentable
  end

end
