# encoding: utf-8
#
class Auth < ActiveRecord::Base
  include BelongsToSomebody
  validates :somebody, :uid, :provider, :data, :presence => true
  validates :uid, :uniqueness => { :scope => :provider }
end
