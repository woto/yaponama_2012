class Admin::Opts::AccumulatorsController < Admin::Opts::AbstractController
  private

  def set_resource_class
    @resource_class = ::Opts::Accumulator
  end

end
