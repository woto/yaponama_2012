class SellerNotifierPreview < ActionMailer::Preview
  def email
    SellerNotifierMailer.email(Talk.last)
  end

  def payment
    SellerNotifierMailer.payment(Payment.last)
  end
end
