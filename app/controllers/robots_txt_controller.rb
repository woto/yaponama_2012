class RobotsTxtController < ApplicationController
  include SetResourceClassDummy

  def index
    @blocked_bots = Bot.where(block: true).where.not(user_agent: nil)
    render 'index', layout: false
  end

  private

end
