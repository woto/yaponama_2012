# encoding: utf-8
#
class TalksController < ApplicationController
  before_action :set_talk, only: [:show, :edit, :update, :destroy]

  def item
  end

  ## GET /talks
  ## GET /talks.json
  #def index
  #  @talks = @user.talks.order(id: :desc)
  #end

  # GET /talks/1
  # GET /talks/1.json
  def show
    #debugger
    #render(template: 'talks/_show.json.jbuilder', locals: { talk: @talk })
    #debugger
    json = render_to_string(template: 'talks/_show.json.jbuilder', locals: { talk: @talk })
    $redis.publish('talk', json)
    render :nothing => true
  end

  ## GET /talks/new
  #def new
  #  @talk = Talk.new
  #end

  ## GET /talks/1/edit
  #def edit
  #end

  # POST /talks
  # POST /talks.json
  def create
    # TODO Тут видимо надо дописать проверку возможности публикации сообщения определенному пользователю, пока сейчас просто добавлю user_id в форму вида
    #debugger
    @talk = Talk.new(talk_params)
    @talk.code_1 = 'chat'
    #@talk.controller = params[:controller]
    #@talk.action = params[:action]
    debugger

    respond_to do |format|
      if @talk.save
        #$redis.publish('talk', @talk.to_json)
        format.html { redirect_to admin_user_talk_path(@user, @talk), notice: 'Talk was successfully created.' }
        format.json { render action: 'show', status: :created, location: @talk }
      else
        format.html { render action: 'new' }
        format.json { render json: @talk.errors, status: :unprocessable_entity }
      end
    end
  end

  ## PATCH/PUT /talks/1
  ## PATCH/PUT /talks/1.json
  #def update
  #  respond_to do |format|
  #    if @talk.update(talk_params)
  #      format.html { redirect_to @talk, notice: 'Talk was successfully updated.' }
  #      format.json { head :no_content }
  #    else
  #      format.html { render action: 'edit' }
  #      format.json { render json: @talk.errors, status: :unprocessable_entity }
  #    end
  #  end
  #end

  # DELETE /talks/1
  # DELETE /talks/1.json
  #def destroy
  #  @talk.destroy
  #  respond_to do |format|
  #    format.html { redirect_to talks_url }
  #    format.json { head :no_content }
  #  end
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_talk
      @talk = Talk.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def talk_params
      params.require(:talk).permit!
    end
end
