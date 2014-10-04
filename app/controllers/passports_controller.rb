# encoding: utf-8
#
class PassportsController < ProfileablesController
  include Grid::Passport

  private

  def set_resource_class
    @resource_class = Passport
  end

end
