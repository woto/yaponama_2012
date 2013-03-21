class SpareInfo < ActiveRecord::Base
  after_save :create_page_upload_associations

  def create_page_upload_associations
    #debugger
    puts 1
  end
end
