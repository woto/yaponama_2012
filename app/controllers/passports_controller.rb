# encoding: utf-8
#
class PassportsController < ProfileablesController
  include GridPassport

  private

  def set_resource_class
    @resource_class = Passport
  end

end
