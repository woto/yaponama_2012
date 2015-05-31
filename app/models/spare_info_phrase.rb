class SpareInfoPhrase < ActiveRecord::Base

  belongs_to :spare_info

  validates :catalog_number, :presence => true, uniqueness:  { case_sensitive: false, :scope => :spare_info_id }

  ransacker :catalog_number_string_length do
    Arel.sql('length(catalog_number)')
  end

  before_save do
    self.phrase = catalog_number.
      gsub(/[^[:alnum:]]/i, ' ').
      gsub(/[[:space:]]+/, ' ').
      strip.
      gsub(' ', ' !').
      prepend('!')
  end

end
