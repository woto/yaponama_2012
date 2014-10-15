class BuyerNotifierPreview < ActionMailer::Preview

  def email
    BuyerNotifierMailer.email(Talk.last, Rails.application.config_for('application/mail')['from'])
  end

  def phone
    BuyerNotifierMailer.phone(Talk.last, '+71234567890')
  end

end
