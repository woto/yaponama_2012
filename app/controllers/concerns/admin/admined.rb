# encoding: utf-8
#
module Admin::Admined

  extend ActiveSupport::Concern

  included do
    skip_before_action :set_grid, only: [:new, :create, :edit, :update, :show, :destroy, :search]
    before_action :prepend_view_paths
    before_action :only_authenticated
    #before_action :set_supplier

    layout 'admin'

    private

    def prepend_view_paths
      prepend_view_path "app/views/admin"
    end

    def only_authenticated
      unless ['admin', 'manager'].include? current_user.role
        redirect_to root_path, :attention => "У вас нет доступа к этой части сайта." and return
      end
    end

    def set_user_and_creation_reason
      super
      if @resource.respond_to? :code_1=
        @resource.code_1 = 'backend'
      end

      if @resource.respond_to? :phantom=
        @resource.phantom = false
      end
    end

    private

    def user_set
      #binding.pry
      #super
      #if request.path.scan('users').any?
      if params[:user_id]
        @somebody = @user = User.find(params[:user_id]) 
      end
      #end
    end

    def somebody_set
      #binding.pry
      #super
      #@somebody = Somebody.find(params[:somebody_id]) if params[:somebody_id]
    end

    def supplier_set
      #binding.pry
      #super
      #if request.path.scan('suppliers').any?
      if params[:supplier_id]
        @somebody = @supplier = Supplier.find(params[:supplier_id]) 
      end
      #end
    end

  end

end
