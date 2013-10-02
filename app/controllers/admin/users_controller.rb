# encoding: utf-8
#
class Admin::UsersController < UsersController
  include Admin::Admined

  # GET /users
  # GET /users.json
  def index
    # TODO тут избавиться от scoped и в includes наверно включить ping
    users_scope = User.scoped

    if params[:role].present? && params[:role] != 'all'
      users_scope = users_scope.where(:role => params[:role])
    end

    # TODO Тут должна быть сортировка
    @users = users_scope.page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @user }
    end
  end

  def edit
    unless @user
      @user = User.new(SiteConfig.default_user_attributes)
      @user.creation_reason = :manager

      unless @user.account
        @user.build_account
      end
    end

    render "edit"

  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(SiteConfig.default_user_attributes.merge( user_params || {} ) )
    # Наличие пароля не обязательно при создании, необходимо так же сделать кнопочки чтобы администратор мог инициировать смену пароля пользователем через email, sms

    unless @user.persisted?
      @user.creation_reason = :manager
      @user.build_account
    end

    respond_to do |format|
      if @user.save
        format.html { redirect_to edit_admin_user_path(@user, :tab => params[:tab]), :notice => 'Пользователь был успешно создан.' }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update_attributes(user_params)
        format.html { redirect_to edit_admin_user_path(@user, :tab => params[:tab]), :notice => 'Пользователь был успешно изменен.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to admin_users_url }
      format.json { head :no_content }
    end
  end

  def logout_from_all_places
    @user.generate_token :auth_token, :long
    @user.save!
    redirect_to admin_user_path(@user), success: "Вы разлогинили пользователя со всех компьютеров. Теперь ему потребуется заново войти на сайт."
  end

  private

  def user_params
    params.require(:user).permit!
  end

end
