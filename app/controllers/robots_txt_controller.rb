class RobotsTxtController < ApplicationController
  skip_before_action :set_resource_class
  layout false

  private

  def find_resources
    @resources = Bot.where(block: true).where.not(user_agent: nil)
  end

end
