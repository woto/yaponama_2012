$(document).on 'page:update', ->
  options = {
    valueNames: [ 'brand' ]
    page: 12,
    plugins: [ ListPagination({}) ] 
  }

  brand_list = new List('brands', options);
