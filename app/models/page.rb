class Page < ActiveRecord::Base
  attr_accessible :content, :description, :keywords, :path, :robots, :title

  before_validation :cut_first_slash

  validates :path, :presence => true

  def cut_first_slash
    self.path = self.path.gsub(/^\/+/, '')
  end

end
