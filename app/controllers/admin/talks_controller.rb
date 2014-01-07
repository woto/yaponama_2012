# encoding: utf-8
#
class Admin::TalksController < TalksController
  include Admin::Admined
  layout 'lightweight', only: [:modal]

  def modal
    super
    @resource.addressee = @somebody
  end


  def user_set
    @somebody = @user = User.find(params[:user_id]) if params[:user_id]
  end

  def somebody_set
  end

  def supplier_set
  end

end
