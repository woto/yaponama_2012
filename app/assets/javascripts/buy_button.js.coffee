$(document).on 'click', '.buy-button', event, -> 
  event.preventDefault()
  $("#product_catalog_number").val($(this).data('catalog-number'))
  $("#product_sell_cost").val($(this).data('cost'))
  $("#product_quantity_available").val($(this).data('count'))
  $("#product_min_days").val($(this).data('min-days'))
  $("#product_max_days").val($(this).data('max-days'))
  $("#product_probability").val($(this).data('probability'))
  $("#s2id_product_brand_attributes_name").select2('val', $(this).data('manufacturer'));
  $("#product_buy_cost").val($(this).data('income-cost'))
  $("#product_short_name").val($(this).data('short-name'))
  $("#product_long_name").val($(this).data('long-name'))
  
  
  # TODO Доработаю позже когда буду разбираться с поставщиком
  #data-country="" data-tech="[&quot;ООО \&quot;Рапида\&quot;, &quot;, &quot;ДЖИПШОП, &quot;, &quot;, &quot;, &quot;ДЖИПШОП , &quot;, &quot;, &quot;, &quot;1110, &quot;]" data-title="" href="#">
