module SpareCatalogGroupHelper
  def nice_tree(tree)
    capture do
      safe_join(tree.map do |t|
        content_tag :span, t.to_label
      end, " #{icon('angle-right')} ".html_safe)
    end
  end

  def nested_dropdown(items)
    result = []
    items.map do |item, sub_items|
      result << [('- ' * item.depth) + item.name, item.id]
      result += nested_dropdown(sub_items) unless sub_items.blank?
    end
    result
  end


  def build_full_tree(arrange, spare_catalogs, block)
    arrange.map do |row, sub_rows|
      render(partial: "/spare_catalog_groups/spare_catalog_group", locals: {spare_catalog_group: row, sub_rows: sub_rows, spare_catalogs: spare_catalogs, block: block})
    end.join.html_safe
  end

end
