class Admin::FaqsController < FaqsController
  include Admin::Admined
  before_filter :set_grid, only: [:index]
  #skip_before_filter :set_grid, only: [:new, :create, :edit, :update, :show, :destroy]

  def index
  end
end
