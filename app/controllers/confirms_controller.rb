# encoding: utf-8

class ConfirmsController < ApplicationController

  before_action :only_authenticated, only: [:ask, :new]
  before_action :anonymous_contact, only: [:make]
  before_action :user_contact, only: [:view, :ask]

  def ask

    @contact.force_confirm!
    @contact.save

    redirect_to url_for(action: 'view'), notice: t("helpers.flash.confirm.#{params[:resource_class]}")
  end

  def make

    @contact.pin_required = true

    if @contact.update(confirm_params)
      if @user.role == 'guest'
        redirect_to root_path, notice: "#{@contact.to_label} успешно подтвержден"
      else
        redirect_to user_path, notice: "#{@contact.to_label} успешно подтвержден"
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
      notice = 'Ваш номер телефона уже подтвержден.'
    when 'Email'
      @contact = @user.emails.where(id: params[:id]).not_confirmed.first
      notice = 'Ваш электронный адрес уже подтвержден.'
    end

    unless @contact
      redirect_to user_path, notice: notice
    end

  end

  def confirm_params
    params.require(:confirm).permit!
  end

end