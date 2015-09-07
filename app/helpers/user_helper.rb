module UserHelper

  def guest_or_user_to_label(user)
    if user.role == 'guest'
      "#{user.id.to_s.scan(/.{3}|.+/).join("-")} #{Date.today}"
    else
      user_to_label(user)
    end
  end

  def user_to_label(user)
    user.name.presence || user.email.presence || user.phone.presence
  end

end
