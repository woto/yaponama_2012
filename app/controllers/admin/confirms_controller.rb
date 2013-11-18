# encoding: utf-8
#
class Admin::ConfirmsController < ConfirmsController
  include Admin::Admined
  def ask
    _ask
    redirect_to :back, info: t("helpers.flash.admin_confirm.#{params[:resource_class]}")
  end
end
