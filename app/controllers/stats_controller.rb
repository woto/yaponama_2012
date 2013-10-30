# encoding: utf-8

class StatsController < ApplicationController

  include SetUserAndCreationReasonDummy
  include CreateResourceDummy
  include SetResourceClassDummy

  def create
    current_user.russian_time_zone_auto_id = - params['russian_time_zone_auto_id'].to_f.round
    current_user.stats.new(stat_params)
    current_user.save!

    #current_user.stats.create!(stat_params)

    render :nothing => true
  end

  private

  def stat_params
    params.require(:stat).permit(:location, :title, :referrer, :screen_width, :screen_height, :client_width, :client_height)
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
