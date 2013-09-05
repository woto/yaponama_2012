#encoding: utf-8

class PasswordResetsController < ApplicationController
  before_action :only_not_authenticated

  def contacts

    @password_reset = PasswordReset.new(password_reset_params)

    if request.post?

      if @password_reset.valid?

        user = @password_reset.user
        user.generate_token(:password_reset_token, :short)
        user.password_reset_sent_at = Time.zone.now
        # TODO Защититься
        #user.password_reset_attempts = 0
        user.save!

        case @password_reset.with
        when 'email'
          PasswordResetMailer.email(@password_reset.value, user.password_reset_token).deliver
        when 'phone'
          PasswordResetMailer.phone(@password_reset.value, user.password_reset_token).deliver
        end

        redirect_to pin_password_reset_path(
          "password_reset" => { 
            "value" => @password_reset.value, 
            "with" => @password_reset.with 
        }), notice: t("helpers.flash.password_reset.#{@password_reset.with}")
 

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

      user = @password_reset.user

      user.password = @password_reset.password

      if user.save!
        redirect_to root_url, :notice => "Вы успешно сменили пароль, теперь можете войти на сайт." and return
        # TODO если захочу автоматически вводить пользователя под своим аккаунтом, то объединить с логином
        # т.к. необходимо склеивание аккаунтов.
      end
    else
      render 'password'
    end
  end

  def password_reset_params
    params.require(:password_reset).permit!
  end

end
