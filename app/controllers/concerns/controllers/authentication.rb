module Concerns::Controllers::Authentication
  extend ActiveSupport::Concern
  included do

    include Pundit

    def current_user
      unless defined? @current_user
        bot = ::Bot.matched_records_by_remote_ip(request.remote_ip).matched_records_by_user_agent(request.user_agent).first
        if bot
          if bot.block
            raise BanishError
          else
            @current_user = nil
          end
        else
          @current_user = super || guest_user
        end
      end
      @current_user
    end

    def guest_user
      if session[:guest_user_id]
        User.find_by(id: session[:guest_user_id]) || create_guest_user
      else
        create_guest_user
      end
    end

    def create_guest_user
      User.create!(role: :guest).tap do |u|
        session[:guest_user_id] = u.id
      end
    end

    protected

    def after_sign_in_path_for(resource)
      if resource.products.incart.exists?
        user_cart_index_path
      else
        user_path
      end
    end

  end
end
