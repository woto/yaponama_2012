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

  # Не очень хорошо получилось. TODO, возможно метод #index нужно вынести в admin
  # или общий модуль для фронтенда и бекенда
  def index
    respond_to do |format|
      format.html
      format.js { render 'grid_filter' }
    end
  end

end
