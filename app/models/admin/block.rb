class Admin::Block < ActiveRecord::Base
  attr_accessible :content, :name
end
