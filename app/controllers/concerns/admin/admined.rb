module Admin::Admined

  extend ActiveSupport::Concern

  included do
    layout 'admin'
    before_action :prepend_view_paths

    private

    def prepend_view_paths
      prepend_view_path "app/views/admin"
    end

  end

end
