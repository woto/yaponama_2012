class SellerNotifierPreview < ActionMailer::Preview
  def payment
    SellerNotifierMailer.payment(Payment.last)
  end

  def incart
    SellerNotifierMailer.incart(Product.last)
  end

  def callback
    SellerNotifierMailer.callback(Callback.last)
  end
end
