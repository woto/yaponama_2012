# encoding: utf-8
#
class ProfilesController < ProfileablesController
  include GridProfile

  def new
    super
    @resource.names.new
    @resource.phones.new(hide_remove_button_on_first_on_new: true, mobile: true)
  end

  private

  def set_resource_class
    @resource_class = Profile
  end

end
