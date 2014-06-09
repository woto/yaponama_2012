# encoding: utf-8
#
class TalksController < ApplicationController

  skip_before_action :find_resource, only: [:modal, :load_older_talks]

  def item
  end

  def update
    respond_to do |format|
      if @resource.save
        format.js { render nothing: true }
      end
    end
  end

  # POST /talks
  # POST /talks.json
  def create
    @talk.code_1 = 'chat'

    respond_to do |format|

      if @talk.save

        format.html { redirect_to admin_user_talk_path(@user, @talk), notice: 'Talk was successfully created.' }
        format.js do
          #redirect_to action: 'modal'
          render js: '$("#talk-temporary").text("Чат норм")'
        end
        format.json { render action: 'show', status: :created, location: @talk }
      else
        #binding.pry
        format.html { render action: 'new' }
        format.js do
          render 'new'
        end
        format.json { render json: @talk.errors, status: :unprocessable_entity }
      end
    end
  end

  def load_older_talks
    load_older_talks_sub(params[:last_id])
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

    if @talk.respond_to? :code_1=
      @talk.code_1 = 'frontend'
    end
  end

  def load_older_talks_sub(last_id=nil)

    t = Talk.arel_table
    u = User.arel_table

    sellers = User.where((u[:role]).in(['manager', 'admin'])).pluck(:id)

    pred1 = t[:somebody_id].eq(@somebody.id)
    pred2 = t[:addressee_id].eq(@somebody.id)
    pred3 = t[:creator_id].eq(@somebody.id)

    @talks = Talk.where(t.grouping(pred1).or(t.grouping(pred2)).or(t.grouping(pred3)))

    if last_id
      @talks = @talks.where("id <= ?", last_id)
    end

    @talks = @talks.order(id: :desc).limit(3)

  end

end
