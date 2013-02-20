class StatsController < ApplicationController

  # POST /stats
  # POST /stats.json
  def create

    attributes = {}

    # GEO
    geo = Ipgeobase.lookup(request.remote_ip)
    attributes[:city] = geo.city.encode if geo.city.present?
    attributes[:country] = geo.country.encode if geo.country.present?
    attributes[:region] = geo.region.encode if geo.region.present?
    attributes[:district] = geo.district.encode if geo.district.present?
    attributes[:lat] = geo.lat if geo.lat.present?
    attributes[:lng] = geo.lng if geo.lng.present?

    # REQUEST
    attributes[:remote_ip]	          = request.remote_ip.to_s
    attributes[:user_agent]	          = request.user_agent.to_s
    attributes[:accept_language]	  = request.accept_language.to_s

    attributes.merge!(stat_params)

    @current_user.stats.create(attributes)

    render :nothing => true

  end

  private

  def stat_params
    params.require(:stat).permit!
  end

end
