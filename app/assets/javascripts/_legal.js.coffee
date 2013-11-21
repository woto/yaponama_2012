$(document).on 'shown', 'a[data-toggle="tab"]', ->
  $(this).tab('show');
  name = $(this).data('radio')
  $("#" + name).prop('checked', true).change()

# По-видимому этот код использовался в старой форме заказа - перключение между юр и физ лицом