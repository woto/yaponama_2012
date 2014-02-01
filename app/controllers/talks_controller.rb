# encoding: utf-8
#
class TalksController < ApplicationController

  layout 'lightweight', only: [:modal]

  skip_before_action :find_resource, only: [:modal, :load_older_talks]

  def item
  end

  ## GET /talks
  ## GET /talks.json
  #def index
  #  @resource = @user.talks.order(id: :desc)
  #end

  # GET /talks/1
  # GET /talks/1.json
  def show
  end

  def modal
    @resource = @somebody.talks.new
    @resource.addressee = current_user.default_addressee
    chat = @resource.talkable = Talkables::Chat.new
    chat_part = chat.chat_parts.new
    chat_part.chat_partable = Talkables::ChatPartables::Text.new
    load_older_talks_sub()
  end

  ## GET /talks/new
  #def new
  #  @resource = Talk.new
  #end

  ## GET /talks/1/edit
  #def edit
  #end

  # POST /talks
  # POST /talks.json
  def create
    creator_role = @resource.creator.role
    addressee_role = @resource.addressee.try(:role)

    # TODO Тут видимо надо дописать проверку возможности публикации сообщения определенному пользователю, пока сейчас просто добавлю user_id в форму вида
    #@resource = Talk.new(resource_params)
    @resource.code_1 = 'chat'
    #@resource.read = true if creator_role.in?(['admin', 'manager']) && addressee_role.in?(['guest', 'user'])
    @resource.read = true if addressee_role.in?(['guest', 'user'])
    #debugger

    respond_to do |format|

      if @resource.save

        if @resource.addressee

          # Если есть получатель
          # И я селлер
          # то я становлюсь дефолтным селлером у получателя
          if ['admin', 'manager'].include? creator_role
            addressee = @resource.addressee
            addressee.default_addressee = @resource.creator #current_user
            addressee.save!
          end

        else

          # Если получателя нет
          # то сбрасывается дефолтный селлер
          current_user.default_addressee = nil
          current_user.save!

        end

        # Если получатель селлер
        # то он становится дефолтным
        if ['admin', 'manager'].include? addressee_role
          current_user.default_addressee = @resource.addressee
          current_user.save!
        end


        #### Если получатель - селлер, то он автоматически становится
        #### дефолтным получателем отправителя
        #### TODO Возможно я могу это перенести в модель.
        #### UPD. Я могу это перенести в модель, но из-за того что current_user не выставляется
        #### при получении письма пока не переделаю, нет
        ###if ['admin', 'manager'].include? addressee_role
        ###  current_user.default_addressee = @resource.addressee
        ###  current_user.save
        ####elsif ['admin', 'manager'].include? @resource.creator.role
        ####  addressee = @resource.addressee
        ####  addressee.default_addressee = current_user
        ####  addressee.save!
        ###elsif !@resource.addressee
        ###  current_user.default_addressee = nil
        ###  current_user.save!
        ###end

        format.html { redirect_to admin_user_talk_path(@user, @resource), notice: 'Talk was successfully created.' }
        format.js do
          redirect_to action: 'modal'
        end
        format.json { render action: 'show', status: :created, location: @resource }
      else
        format.html { render action: 'new' }
        format.js do
          render 'new'
        end
        format.json { render json: @resource.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /talks/1
  # DELETE /talks/1.json
  #def destroy
  #  @resource.destroy
  #  respond_to do |format|
  #    format.html { redirect_to talks_url }
  #    format.json { head :no_content }
  #  end
  #end

  def load_older_talks
    load_older_talks_sub(params[:last_id])
  end

  private

  def set_resource_class
    @resource_class = Talk
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
