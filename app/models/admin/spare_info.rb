class Admin::SpareInfo < ActiveRecord::Base
  attr_accessible :catalog_number, :content, :manufacturer
end
