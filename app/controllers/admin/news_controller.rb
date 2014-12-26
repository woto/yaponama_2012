class Admin::NewsController < NewsController

  include Grid::News
  include Admin::Admined

  def create
    super
  end

  def update
    super
  end

  def show
    super
  end

  def edit
    super
  end
end
