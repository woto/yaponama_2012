class MakeDefaultSpareCatalogGroupAndMoveSpareCatalogsThere < ActiveRecord::Migration
  def change
    spare_catalog_group = SpareCatalogGroup.create!(name: 'Прочие')
    SpareCatalog.update_all(spare_catalog_group_id: spare_catalog_group.id)
  end
end
