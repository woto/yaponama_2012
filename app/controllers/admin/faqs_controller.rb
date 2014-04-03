class Admin::FaqsController < FaqsController
  include Admin::Admined
  before_filter :set_grid, except: [:new, :create, :edit, :update, :show, :destroy]

  def index
    super
  end

end
