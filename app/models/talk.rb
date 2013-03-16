class Talk < ActiveRecord::Base
  belongs_to :talkable, polymorphic: true, :dependent => :destroy
  belongs_to :user
  belongs_to :creator
end
