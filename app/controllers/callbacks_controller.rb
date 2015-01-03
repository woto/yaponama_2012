class CallbacksController < ApplicationController

  def create
    super
    SellerNotifierMailer.callback(@resource).deliver_later
  end
  
  private

  def set_resource_class
    @resource_class = ::Callback
  end

end
