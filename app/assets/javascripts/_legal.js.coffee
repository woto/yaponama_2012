$(document).on 'shown', 'a[data-toggle="tab"]', ->
  $(this).tab('show');
  name = $(this).data('radio')
  $("#" + name).prop('checked', true).change()

