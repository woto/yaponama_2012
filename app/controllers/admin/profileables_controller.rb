class Admin::ProfileablesController < ProfileablesController
  include Admined

  private

  #def find_approrirate_resources
  #  @resources = @resource_class.where(:user_id => params[:user_id])
  #end

end
