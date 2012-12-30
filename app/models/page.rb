class Page < ActiveRecord::Base
  attr_accessible :content, :description, :keywords, :path, :robots, :title

  before_save :cut_first_slash

  validates :path, :presence => true, :uniqueness => {case_sensitive: false}

  has_and_belongs_to_many :uploads

  def cut_first_slash
    self.path = self.path.gsub(/^\/+/, '')
  end

end
