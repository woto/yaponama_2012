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
    params.require(:stat).permit(:location, :title, :referrer)
  end

end
