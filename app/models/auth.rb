class Auth < ActiveRecord::Base
  belongs_to :user, :inverse_of => :auths
  validates :user, :uid, :provider, :data, :presence => true
  validates :uid, :uniqueness => { :scope => :provider }
end
