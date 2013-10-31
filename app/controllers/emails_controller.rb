class EmailsController < ProfileablesController
  include GridEmail

  private

  def set_resource_class
    @resource_class = Email
  end

end
