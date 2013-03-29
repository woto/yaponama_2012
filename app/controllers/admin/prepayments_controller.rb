class Admin::PrepaymentsController < ApplicationController
  include Admined

  def edit
  end

  def update
    respond_to do |format|
      if @user.update_attributes(user_params)
        format.html { redirect_to edit_admin_user_path(@user, :tab => params[:tab]), :notice => 'Prepayment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  private

  def user_params
    params.require(:user).permit!
  end

end
