class UsersController < ApplicationController
  before_action :only_authenticated, :only => [:show]

  def show
    @user = current_user

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @user }
    end
  end

end
