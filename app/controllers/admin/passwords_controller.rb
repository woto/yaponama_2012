class Admin::PasswordsController < PasswordsController
  include Admin::Admined

  def update
    super
  end

  private

  def find_resource
    super
  end


end
