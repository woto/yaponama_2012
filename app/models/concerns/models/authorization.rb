module Concerns::Models::Authorization

  extend ActiveSupport::Concern

  included do
    enum role: [:guest, :user, :manager, :admin]
  end

  def seller?
    [:manager, :admin].include? role
  end

  def buyer?
    [:guest, :user].include? role
  end

end
