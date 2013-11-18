# encoding: utf-8
#
class WelcomeController < ApplicationController

  include SetResourceClassDummy

  def index
  end

  def user_set
    @user = current_user
  end

  def somebody_set
    @somebody = current_user
  end

  def supplier_set
  end

end
