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
          format.html { redirect_to url_for(:action => :show, :return_path => params[:return_path], :id => @resource.id) }
        else
          format.html { render action: 'new' }
        end
      end
    end

    def update
      respond_to do |format|
        if @resource.save
          format.html { redirect_to url_for(:action => :show, :return_path => params[:return_path]) }
        else
          format.html { render action: 'edit' }
        end
      end
    end

    def destroy
      respond_to do |format|
        if @resource.destroy
          notice = %Q(#{I18n.t(@resource_class)} "#{@resource.to_label}" Был успешно удален)
          if params[:return_path].present?
            format.html { redirect_to url_for(params[:return_path]), notice: notice }
          else
            format.html { redirect_to url_for(action: :index), notice: notice }
          end
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
