$(document).on('custom-change', 'select#orders_delivery_form_postal_address_id', function(event) {
  if($(event.currentTarget).find('option:selected').val() == "-1") {
    $('#new-postal-address').show();
  } else {
    $('#new-postal-address').hide();
  }
});
