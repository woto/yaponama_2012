# encoding: utf-8
#
class ConfirmsController < ApplicationController

  include SetResourceClassDummy

  before_action :only_authenticated, only: [:new]
  before_action :anonymous_contact, only: [:make]
  before_action :user_contact, only: [:view, :ask]

  skip_before_action :find_resource, :only => [:view, :ask, :make]

  def ask
    _ask
    redirect_to url_for(action: 'view', return_path: params[:return_path]), info: t("helpers.flash.confirm.#{params[:resource_class]}")
  end

  def make
    @contact.pin_required = true

    if @contact.update(confirm_params)
      if @user.role == 'guest'
        #redirect_to edit_register_path(with: @contact.class.name.underscore), success: "<strong>#{@contact.to_label}</strong> успешно подтвержден. Пожалуйста завершите регистрацию придумав пароль.".html_safe
        redirect_to root_path, success: "<strong>#{@contact.to_label}</strong> успешно подтвержден.".html_safe
      else
        redirect_to user_path, success: "<strong>#{@contact.to_label}</strong> успешно подтвержден.".html_safe
      end
    else
      render 'view'
    end

  end

  def view
  end

  private

  # TODO Сделать как-нибудь красивее. Цель - сделать возможным работу ссылки для подтверждения
  # для любого., напр. чтобы была возможности перейти по ссылке с телефона будучи не залогиненым

  def anonymous_contact
    case params[:resource_class]
    when 'Phone'
      @contact = Phone.where(id: params[:id]).not_confirmed.first
    when 'Email'
      @contact = Email.where(id: params[:id]).not_confirmed.first
    end

    unless @contact
      redirect_to root_path
    end
  end

  def user_contact
    case params[:resource_class]
    when 'Phone'
      @contact = @user.phones.where(id: params[:id]).not_confirmed.first
      success = 'Ваш номер телефона уже подтвержден.'
    when 'Email'
      @contact = @user.emails.where(id: params[:id]).not_confirmed.first
      success = 'Ваш электронный адрес уже подтвержден.'
    end

    unless @contact
      redirect_to user_path, success: success
    end

  end

  def confirm_params
    params.require(:confirm).permit!
  end

  private

  def _ask
    @contact.force_confirm!
    @contact.save
  end

end
