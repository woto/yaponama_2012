class CatalogsController < ApplicationController
  skip_before_action :find_resource

  def show
    @brands = Brand.
      joins(:spare_applicabilities).
      order("brands.name").
      where("spare_applicabilities.brand_id IS NOT NULL").
      select("brands.id, brands.name, brands.image, count(spare_applicabilities.id) as count").
      group("brands.id")
  end
end
