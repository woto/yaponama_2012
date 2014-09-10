class BuyerNotifierPreview < ActionMailer::Preview

  def email
    BuyerNotifierMailer.email(Talk.last, CONFIG.mail['from'])
  end

  def phone
    BuyerNotifierMailer.phone(Talk.last, '+71234567890')
  end

end
