# encoding: utf-8

class StatsController < ApplicationController
  include ActionController::Live

  # POST /stats
  # POST /stats.json
  def create
    attributes = {}

    # GEO
    begin
      geo = Ipgeobase.lookup(request.remote_ip)
      attributes[:city] = geo.city.encode if geo.city.present?
      attributes[:country] = geo.country.encode if geo.country.present?
      attributes[:region] = geo.region.encode if geo.region.present?
      attributes[:district] = geo.district.encode if geo.district.present?
      attributes[:lat] = geo.lat if geo.lat.present?
      attributes[:lng] = geo.lng if geo.lng.present?
    rescue Exception
      Rails.logger.info "Не удалось получить данные Ipgeobase"
    end

    # REQUEST
    attributes[:remote_ip]	          = request.remote_ip.to_s
    attributes[:user_agent]	          = request.user_agent.to_s
    attributes[:accept_language]	  = request.accept_language.to_s

    attributes.merge!(stat_params)

    @current_user.stats.create(attributes)

    Redis.new.publish('stats.create', @stat.to_json)
    render :nothing => true
  end

  def events
    ActiveRecord::Base.connection.disconnect!
    response.headers["Content-Type"] = "text/event-stream"
    redis = Redis.new
    redis.psubscribe('stats.*') do |on|
      on.pmessage do |pattern, event, data|
        response.stream.write("event: #{event}\n")
        response.stream.write("data: #{data}\n\n")
      end
    end
  rescue IOError
    logger.info "Stream closed"
  ensure
    redis.quit
    response.stream.close
  end

  private

  def stat_params
    params.require(:stat).permit!
  end

end
