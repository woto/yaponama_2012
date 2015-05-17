class ConfirmsController < ApplicationController

  include SetResourceClassDummy

  before_action :only_authenticated, only: [:new]
  before_action :anonymous_contact, only: [:make]
  before_action :user_contact, only: [:view, :ask]

  def ask
    _ask
    redirect_to url_for(action: 'view'), info: t("helpers.flash.confirm.#{params[:resource_class]}"), turbolinks: false
  end

  def make
    @contact.pin_required = true

    if @contact.update(confirm_params)
      if @contact.profile.somebody.role == 'guest'
        cookies[:auth_token] = { :expire => nil, :value => @contact.profile.somebody.auth_token } 
        redirect_to edit_register_path(with: @contact.class.name.underscore), attention: "#{@contact.to_label} успешно подтвержден.", turbolinks: true
      else
        redirect_to user_path, attention: "#{@contact.to_label} успешно подтвержден."
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
    # TODO TODO TODO!
    case params[:resource_class]
    when 'Phone'
      @contact = Phone.where(id: params[:id], confirmed: false).first
    when 'Email'
      @contact = Email.where(id: params[:id], confirmed: false).first
    end

    unless @contact
      raise AuthenticationError.new 'Ссылка подтверждения не верна.'
    end
  end

  def user_contact
    case params[:resource_class]
    when 'Phone'
      @contact = @user.phones.where(id: params[:id], confirmed: false).first
      attention = 'Ваш номер телефона уже подтвержден.'
    when 'Email'
      @contact = @user.emails.where(id: params[:id], confirmed: false).first
      attention = 'Ваш электронный адрес уже подтвержден.'
    end

    unless @contact
      #raise AuthenticationError.new(attention)
      redirect_to polymorphic_path([*jaba3]), attention: attention
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

  def set_resource_class
    @resource_class = params[:resource_class].constantize
  end

  def find_resource
    begin
      @resource = @resource_class.find(params[:id])
    rescue
      AuthenticationError.new 'Ссылка подтверждения не верна'
    end
  end

end
