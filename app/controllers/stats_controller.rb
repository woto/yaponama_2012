# encoding: utf-8

class StatsController < ApplicationController

  # POST /stats
  # POST /stats.json
  def create

    status = Timeout::timeout(5) {

      # GEO
      begin
        remote_ip = request.remote_ip

        if current_user.remote_ip != remote_ip
          res = Ipgeobase.lookup(remote_ip)
          current_user.ipgeobase_city     = res.city.try(:encode)
          current_user.ipgeobase_country  = res.country.try(:encode)
          current_user.ipgeobase_region   = res.region.try(:encode)
          current_user.ipgeobase_district = res.district.try(:encode)
          current_user.ipgeobase_lat      = res.lat
          current_user.ipgeobase_lng      = res.lng
        end
      rescue SocketError => e
        Rails.logger.warn "Не удалось получить данные Ipgeobase #{e.message}"
      end

      current_user.remote_ip                 = remote_ip
      current_user.user_agent                = request.user_agent.to_s
      current_user.accept_language           = request.accept_language.to_s
      current_user.russian_time_zone_auto_id = ((DateTime.parse(params['russian_time_zone_auto']).to_f - DateTime.now.utc.to_f)/3600).round
      current_user.save

      current_user.stats.create!(stat_params)
    }

    render :nothing => true
  end

  private

  def stat_params
    # TODO Security
    params.require(:stat).permit!
  end

end
