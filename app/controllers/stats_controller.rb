# encoding: utf-8

class StatsController < ApplicationController

  # POST /stats
  # POST /stats.json
  def create

    current_user.russian_time_zone_auto_id = ((DateTime.parse(params['russian_time_zone_auto']).to_f - DateTime.now.utc.to_f)/3600).round
    current_user.save

    current_user.stats.create!(stat_params)

    render :nothing => true
  end

  private

  def stat_params
    # TODO Security
    params.require(:stat).permit!
  end

end
