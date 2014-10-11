# encoding: utf-8
#
class Admin::UsersController < UsersController

  include Admin::Admined

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

  def create_resource
    @resource = @resource_class.new(CONFIG.user['default'].merge( resource_params || {} ))
    @resource.build_account
  end

  def logout_from_all_places
    @resource.generate_token :auth_token, :long
    @resource.save!
    flash.now[:attention] = "Вы разлогинили пользователя со всех компьютеров. Теперь ему потребуется заново войти на сайт."
    respond_to do |format|
      format.js { render 'logout_from_all_places' }
    end
  end

  private

  def somebody_set
  end


  def user_set
    #super
    if params[:id]
      @somebody = @user = User.find(params[:id])
    end
  end

  def find_resource
    @resource = @somebody
  end

  # интересно, почему тут не нужен set_resource_class. TODO

end
