class AddRequstIdToCar < ActiveRecord::Base
  belongs_to :request
  # attr_accessible :title, :body
end
