$(document).on 'page:update', ->
  options = {
    valueNames: [ 'brand' ]
    page: 10,
    plugins: [ ListPagination({ }) ],
  }

  brand_list = new List('brands', options);

  # Это находится здесь, потому что необходима сначала инициализация списка, а потом skollr
  unless (/Android|iPhone|iPad|iPod|BlackBerry|Windows Phone/i).test(navigator.userAgent or navigator.vendor or window.opera)
    s = skrollr.init forceHeight: false

  s.refresh();
