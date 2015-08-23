class Catalogs::ModelsController < ApplicationController

  def show

    scgt = SpareCatalogGroup.arel_table
    sct = SpareCatalog.arel_table

    @spare_catalogs = SpareCatalog.
      joins(:spare_infos => :spare_applicabilities).
      joins(sct.join(scgt, Arel::Nodes::OuterJoin).on(scgt[:id].eq(sct[:spare_catalog_group_id])).join_sources).
      where(:spare_applicabilities => {:model_id => params[:id].to_i}).
      select("CONCAT(CONCAT(CASE WHEN spare_catalog_groups.ancestry IS NULL THEN '/' ELSE CONCAT(CONCAT('/', spare_catalog_groups.ancestry), '/') END, spare_catalog_groups.id), '/') as ancestry, spare_catalogs.id, spare_catalogs.name, count(spare_infos.id) as count, LENGTH(spare_catalogs.opt) > 0 special").
      order("spare_catalogs.name").
      group("spare_catalogs.id, spare_catalog_groups.id, spare_catalog_groups.ancestry")
  end

  private
 

  def find_resource
    @model = Model.find(params[:id])
    @brand = @model.brand
  end

end
