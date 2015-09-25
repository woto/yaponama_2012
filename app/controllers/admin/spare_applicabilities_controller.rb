class Admin::SpareApplicabilitiesController < SpareApplicabilitiesController
  include Admin::Admined

  private

  def find_resources
    super
    @q = @resources.ransack(params[:q])
    @resources = @q.result(distinct: true)
  end

end
