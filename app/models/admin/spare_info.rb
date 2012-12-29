class Admin::SpareInfo < ActiveRecord::Base
  attr_accessible :catalog_number, :content, :manufacturer

  after_save :create_page_upload_associations

  def create_page_upload_associations
    #debugger
    puts 1
  end
end
