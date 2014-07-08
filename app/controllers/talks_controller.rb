# encoding: utf-8
#
class TalksController < ApplicationController

  # POST /talks
  # POST /talks.json
  def create
    respond_to do |format|
      if @talk.save
        format.js { redirect_to action: :index, format: :js }
      else
        format.js { render 'new' }
      end
    end
      
  end

  def index
  end

  private

  def set_resource_class
    @resource_class = Talk
  end

  def create_resource
    @talk = @resource_class.new(resource_params)
  end

  def set_user_and_creation_reason
    if @talk.respond_to?(:somebody) && @talk.somebody.blank?
      @talk.somebody = @talk
    end

    # TODO черновой вариант
    if @talk.respond_to?(:creator) && !(@talk.persisted? && @talk.is_a?(Talk))
      @talk.creator = current_user
    end
  end

end
