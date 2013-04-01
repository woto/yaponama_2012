class Auth < ActiveRecord::Base
  include Transactionable
  belongs_to :user
  validates :user_id, :uid, :provider, :data, :presence => true
  validates :uid, :uniqueness => { :scope => :provider }
end
