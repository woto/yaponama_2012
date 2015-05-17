module Actions
  extend ActiveSupport::Concern
  included do

  def new
  end

  def edit
  end

  def show
    respond_to do |format|
      format.html
      format.json { render json: @resource }
      format.js
    end
  end

  def create
    #binding.pry
    # TODO postal_address_type здесь нужен для того чтобы после создания адреса доставки переброска на show происходила с postal_address_type, чтобы на следующем шаге мы знали показывать например поле для ввода квартиры или нет. Потом как-нибудь подумать, как сделать лучше
    respond_to do |format|
      if @resource.save
        format.html { redirect_to url_for(:action => :show, :return_path => params[:return_path], :postal_address_type => params[:postal_address_type], :id => @resource.id) }
        format.js { redirect_to url_for(:action => :show, :return_path => params[:return_path], :postal_address_type => params[:postal_address_type], :id => @resource.id) }
      else
        format.html { render action: 'new' }
        format.js { render action: 'new' }
      end
    end
  end

  def update
    respond_to do |format|
      if @resource.save
        format.html { redirect_to url_for(:action => :show, :return_path => params[:return_path]) }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @resource.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @resource.destroy
        attention = %Q(#{I18n.t(@resource_class)} "#{@resource.to_label}" Был успешно удален)
        if params[:return_path].present?
          format.html { redirect_to url_for(params[:return_path]), attention: attention }
        else
          format.html { redirect_to url_for(action: :index), attention: attention }
        end
        format.json { head :no_content }
      else
        format.html { redirect_to url_for(:controller => :users, :action => :show), attention: "Невозможно удалить" }
      end
    end
  end
end
end
