class Admin::Opts::TruckTiresController < Admin::Opts::AbstractController
  private

  def set_resource_class
    @resource_class = ::Opts::TruckTire
  end

end
