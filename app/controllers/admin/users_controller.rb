#
class Admin::UsersController < UsersController

  include Admin::Admined

  skip_before_filter :set_grid, :only => [:new, :create, :edit, :update, :show, :destroy]

  def transactions

    transactions = SomebodyTransaction

    if params[:id]
      transactions = SomebodyTransaction.where(:somebody_id => params[:id])
    end

    @transactions = transactions.order("id DESC").page(params[:page])

    respond_to do |format|
      format.html { render 'profileables/transactions' }
      format.json { render json: @transactions }
    end
  end

  ## GET /users
  ## GET /users.json
  #def index
  #  ## TODO тут избавиться от scoped и в includes наверно включить ping
  #  ## users_scope = User.scoped
  #  ## TODO обрабатывать online
  #  #users_scope = User.where(online: true)
  #  ##users_scope = User

  #  #if params[:role].present? && params[:role] != 'all'
  #  #  users_scope = users_scope.where(:role => params[:role])
  #  #end

  #  ## TODO Тут должна быть сортировка
  #  #@users = users_scope.page(params[:page])

  #  #respond_to do |format|
  #  #  format.html # index.html.erb
  #  #  format.json { render :json => @users }
  #  #end

  #  respond_to do |format|
  #    format.html
  #    format.js { render 'grid_filter' }
  #  end

  #end

  ## GET /users/1
  ## GET /users/1.json
  #def show
  #  #@user.products.active.includes(:order => :delivery).where(:deliveries => {:full_prepayment_required => true}).summa + 
  #  #@user.products.active.includes(:order => :delivery).where(:deliveries => {:full_prepayment_required => false}).summa * @user.prepayment / 100 

  #  respond_to do |format|
  #    format.html # show.html.erb
  #    format.json { render :json => @resource }
  #  end
  #end

  #def edit
  #  unless @resource
  #    @resource = User.new(SiteConfig.default_user_attributes)
  #    debugger
  #    puts 'aaaaaaaaaaaaaaaaaaaaa'
  #    @resource.creation_reason = :manager

  #    unless @resource.account
  #      @resource.build_account
  #    end
  #  end

  #  render "edit"

  #end

  def create_resource
    @resource = @resource_class.new(SiteConfig.default_somebody_attributes.merge( resource_params || {} ))
    @resource.build_account
  end

  ### PUT /users/1
  ### PUT /users/1.json
  #def update
  #  super
  ##  respond_to do |format|
  ##    if @user.update_attributes(user_params)
  ##      format.html { redirect_to edit_admin_user_path(@user, :tab => params[:tab]), :notice => 'Пользователь был успешно изменен.' }
  ##      format.json { head :no_content }
  ##    else
  ##      format.html { render :action => "edit" }
  ##      format.json { render :json => @user.errors, :status => :unprocessable_entity }
  ##    end
  ##  end
  #end

  ## DELETE /users/1
  ## DELETE /users/1.json
  #def destroy
  #  @resource.destroy

  #  respond_to do |format|
  #    format.html { redirect_to admin_users_url }
  #    format.json { head :no_content }
  #  end
  #end

  def logout_from_all_places
    @resource.generate_token :auth_token, :long
    @resource.save!
    redirect_to admin_user_path(@resource), success: "Вы разлогинили пользователя со всех компьютеров. Теперь ему потребуется заново войти на сайт."
  end

  private

  def user_set
    @user = User.find(params[:id]) if params[:id]
  end

  def somebody_set
    @somebody = User.find(params[:id]) if params[:id]
  end

  def find_resource
    @resource = @user
  end

end
