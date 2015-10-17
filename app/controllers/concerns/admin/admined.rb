module Admin::Admined

  extend ActiveSupport::Concern

  included do
    layout 'admin'
    before_action :prepend_view_paths
    before_action :only_authenticated

    private

    def prepend_view_paths
      prepend_view_path "app/views/admin"
    end

    def only_authenticated
      unless current_user.seller? 
        redirect_to root_path, alert: 'У вас нет доступа к этой части сайта'
      end
    end

  end

end
