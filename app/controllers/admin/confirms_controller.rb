class Admin::ConfirmsController < ConfirmsController
  include Admin::Admined

  before_action :somebody_get, only: [:ask, :view]
  before_action :user_get, only: [:ask, :view]
  before_action :supplier_get, only: [:ask, :view]
  before_action :user_contact, only: [:view, :ask]

end
