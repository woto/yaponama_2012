module ProductsHelper

  def manufacturer_origs(mf_scope)
    raw mf_scope[:manufacturer_origs].keys.map{|val| h(val)}.join(', ')
  end

  def catalog_number_origs(mf_scope)
    raw mf_scope[:catalog_number_origs].keys.map{|val| h(val)}.join(', ')
  end

end
