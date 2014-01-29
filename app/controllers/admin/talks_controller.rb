# encoding: utf-8
#
class Admin::TalksController < TalksController
  include Admin::Admined
  layout 'lightweight', only: [:modal]

  def modal
    super
    @resource.addressee = @somebody
  end

end
