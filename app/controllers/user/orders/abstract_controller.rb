class User::Orders::AbstractController < ApplicationController
  include Users::Concerns::ExistingUser

  def create
    respond_to do |format|
      if @resource.call
        if @resource.user_form.role == 'guest'
          # Сгенерированный пароль лучше сохранять в instance variable,
          # тогда до него можно будет достучаться из тестов
          generated_password = Devise.friendly_token.first(8)
          user = User.create!(role: 'user', password: generated_password, name: @resource.user_form.name,
                              phone: @resource.user_form.phone, email: @resource.user_form.email)
          existing_user(user)
          sign_in(user)
          UserMailer.registration_letter_after_ordering(@resource.order.reload, generated_password).deliver_later
        else
          UserMailer.letter_after_ordering(@resource.order.reload).deliver_later
        end

        notice = "Заказ № #{@resource.to_label} успешно оформлен"
        format.html { redirect_to user_path, notice: notice }
      else
        format.html { render action: 'new' }
      end
    end
  end

  private

  def resource_params
    super.deep_merge({ user_form_attributes: { id: current_user.id.to_s }})
  end

end
