# encoding: utf-8
#
class ProfilesController < ProfileablesController
  include Grid::Profile

  def new
    super
  end

  private

  def set_resource_class
    @resource_class = Profile
  end

end
