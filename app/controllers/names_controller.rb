class NamesController < ProfileablesController
  include GridName

  private

  def set_resource_class
    @resource_class = Name
  end

end
