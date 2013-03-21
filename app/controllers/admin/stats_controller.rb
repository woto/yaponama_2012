class Admin::StatsController < ApplicationController
  include Admined

  def iframe
    $redis = Redis.new(:host => 'localhost', :port => 6379)
    render :text => $redis.get('page')
  end

  # GET /stats/1
  # GET /stats/1.json
  def show
    @stat = Stat.find(params[:id])

    respond_to do |format|
      format.html { render "show" }
      format.json { render json: @stat }
    end
  end

  private

  def stat_params
    params.require(:stat).permit!
  end
end
