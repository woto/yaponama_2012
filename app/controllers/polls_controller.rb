class PollsController < ApplicationController

  def create
    @poll = Poll.new(poll_params)
    @poll.remote_ip = request.remote_ip

    respond_to do |format|
      @poll.save!
      format.js { render :show }
    end
  end

  private

  def poll_params
    params.require(:poll).permit(:price, :awaiting, :reach, :comment, :remote_ip)
  end

  def set_resource_class
    @resource_class = Poll
  end
end
