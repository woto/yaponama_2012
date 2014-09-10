class SellerNotifierPreview < ActionMailer::Preview
  def email
    SellerNotifierMailer.email(Talk.last)
  end
end
