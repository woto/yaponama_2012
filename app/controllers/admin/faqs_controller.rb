class Admin::FaqsController < FaqsController
  include Admin::Admined
  before_filter :set_grid, except: [:create, :update]
  #skip_before_filter :set_grid, only: [:new, :create, :edit, :update, :show, :destroy]

  def index
    super
  end

end
