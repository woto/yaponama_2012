class SellerNotifierPreview < ActionMailer::Preview
  def callback
    SellerNotifierMailer.callback(Callback.last)
  end
end
