# encoding: utf-8
#
module FastEditable

  extend ActiveSupport::Concern

  included do

    skip_before_action :set_grid, only: [:fast_update, :fast_edit]

    def fast_edit
      render layout: false
    end

    def fast_update
      if @resource.update(resource_params)
        redirect_to action: 'fast_show', :primary_key => params[:primary_key]
      else
        render action: 'fast_edit'
      end
    end

    def fast_show
    end

  end

end
