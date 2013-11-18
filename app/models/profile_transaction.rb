# encoding: utf-8
#
class ProfileTransaction < ActiveRecord::Base
  include BelongsToCreator
  include BelongsToSomebody

  #FIELDS =  ['names', 'phones', 'emails', 'passports']
  PREFIXES = ['before', 'after']

  ::Profile::FIELDS .each do |field|
    PREFIXES.each do |prefix|
      instance_eval <<-CODE, __FILE__, __LINE__ + 1
        serialize :cached_#{field}_#{prefix}, JSON
      CODE
    end
  end

end
