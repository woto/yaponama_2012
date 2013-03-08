# encoding: utf-8

class AuthController < ApplicationController
  before_action do
    @auth = request.env['omniauth.auth']
  end

  def create

    # TODO позже разобраться как сделать правильно, пока так набросал чтобы разобраться с полями. Над чем надо подумать:
    # 1. Пользователь может входить на сайт и комментировать с помощью omniauth
    # 2. Пользователь может привязывать доп. аккаунты
    record = Auth.where(uid:  @auth['uid'].to_s, provider: @auth['provider'].to_s).first_or_initialize

    record.user = current_user
    record['data'] = @auth.to_yaml

    if record.changed?
      record.save!
    end

    render :text => "<pre> #{@auth.to_yaml} </pre>"
  end

  def failure
    Rails.logger.error @auth
    raise 'Извините, произошла непредвиденная ошибка.'
  end
end
