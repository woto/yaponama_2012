class Admin::BrandsController < BrandsController
  include Grid::Brand
  include Admin::Admined

  private

  def set_user_and_creation_reason
    super
    @resource.phantom = false
  end

end
