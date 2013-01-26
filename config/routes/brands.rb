class BrandConstraint
  def initialize
    #@ips = Blacklist.retrieve_ips
    #@brand_names = Brand.pluck(:name)
  end
 
  def matches?(request)
    #@ips.include?(request.remote_ip)
    @brand_names = Brand.pluck(:name)
    @brand_names.include? request.params[:brand]
  end
end

Yaponama2012::Application.routes.draw do

  get "*brand" => "brands#index", :constraints => BrandConstraint.new

end
