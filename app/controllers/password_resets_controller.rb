# encoding: utf-8
#
class PasswordResetsController < ApplicationController

  include FindResourceDummy
  include SessionsPasswordResetsCommon
  
  before_action :only_not_authenticated
  before_action { @meta_title = 'Восстановление пароля' }

  def contacts

    @password_reset = PasswordReset.new(password_reset_params)

    if request.post?

      if @password_reset.valid?

        somebody = @password_reset.somebody
        somebody.generate_token(:password_reset_token, :short)
        somebody.password_reset_sent_at = Time.zone.now
        # TODO Защититься
        #somebody.password_reset_attempts = 0
        somebody.save!

        case @password_reset.with
        when 'email'
          PasswordResetMailer.email(@password_reset.value, somebody.password_reset_token).deliver
        when 'phone'
          PasswordResetMailer.phone(@password_reset.value, somebody.password_reset_token).deliver
        end

        redirect_to pin_password_reset_path(
          "password_reset" => { 
            "value" => @password_reset.value, 
            "with" => @password_reset.with 
        }), attention: t("helpers.flash.password_reset.#{@password_reset.with}")
 

      else
        render 'contacts'
      end
    end
  end

  def pin

    @password_reset = PasswordReset.new(password_reset_params)

    if request.post?

      @password_reset.pin_required = true

      if @password_reset.valid?

        redirect_to password_password_reset_path(
          "password_reset" => { 
            "value" => @password_reset.value, 
            "with" => @password_reset.with,
            "pin" => @password_reset.pin
        })

      else
        render "pin"
      end
    end
  end

  def password
    @password_reset = PasswordReset.new(password_reset_params)
    @password_reset.pin_required = true
    @password_reset.valid?
  end

  def done

    @password_reset = PasswordReset.new(password_reset_params)

    @password_reset.pin_required = true
    @password_reset.password_required = true

    if @password_reset.valid?

      somebody = @password_reset.somebody

      somebody.password = @password_reset.password

      if somebody.save!

        authenticated_user = @password_reset.somebody

        session_password_resets_common current_user, authenticated_user

        #@somebody.pass_my_attributes_to_somebody_and_destroy_self(@password_reset.somebody)

        attention = "Вы успешно сменили пароль и автоматически вошли на сайт."
        if authenticated_user.seller?
          redirect_to admin_path, :attention => attention and return
        else
          redirect_to user_path, :attention => attention and return
        end

      end
    else
      render 'password'
    end
  end

  def password_reset_params
    params.require(:password_reset).permit!
  end

  def set_resource_class
    @resource_class = PasswordReset
  end

end
