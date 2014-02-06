# encoding: utf-8
#
module JustBelongsToCreator
  extend ActiveSupport::Concern

  included do 
    belongs_to :creator, :class_name => "User"
    #validates :creator, presence: true
  end

end
