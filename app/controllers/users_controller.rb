class UsersController < ApplicationController
  before_action :only_authenticated, :only => [:show]

  before_filter { @tab = params[:tab] || 'users' }

  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @user }
    end
  end

end
