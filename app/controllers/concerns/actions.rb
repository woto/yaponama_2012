module Concerns::Actions
  extend ActiveSupport::Concern
  included do

    def index
    end

    def new
    end

    def edit
    end

    def show
    end

    def create
      respond_to do |format|
        if @resource.save
          notice = %Q(#{@resource_class.model_name.human} "#{@resource.to_label}" был успешно создан)
          format.html { redirect_to params[:return_path] || url_for(:action => :show, id: @resource.id), notice: notice }
        else
          format.html { render action: 'new' }
        end
      end
    end

    def update
      respond_to do |format|
        if @resource.save
          notice = %Q(#{@resource_class.model_name.human} "#{@resource.to_label}" был успешно обновлен)
          format.html { redirect_to params[:return_path] || url_for(:action => :show, id: @resource.id), notice: notice }
        else
          format.html { render action: 'edit' }
        end
      end
    end

    def destroy
      respond_to do |format|
        if @resource.destroy
          notice = %Q(#{@resource_class.model_name.human} "#{@resource.to_label}" был успешно удален)
          format.html { redirect_to params[:return_path] || url_for(action: :index), notice: notice }
        else
          alert = @resource.errors.full_messages_for(:base).join("<br>")

          if params[:return_path].present?
            format.html { redirect_to url_for(params[:return_path]), alert: alert }
          end
        end
      end
    end
  end
end
