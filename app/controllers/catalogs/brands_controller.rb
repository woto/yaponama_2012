class Catalogs::BrandsController < ApplicationController

  def show
    @models = Model.
      where(brand_id: params[:id].to_i).
      joins(:spare_applicabilities).
      order('models.name').
      where("spare_applicabilities.model_id IS NOT NULL").
      select("models.id, models.name, count(spare_applicabilities.id) as count").
      group("models.id")

    @meta_title = "Запчасти на #{@brand.name}"
    @meta_title_small = "(рус. #{@brand.brands.slang.pluck(:name).join(', ')})" if @brand.brands.slang.exists?
    @discourse = [@meta_title]
  end

  private

  def find_resource
    @brand = Brand.find(params[:id])
  end

end
