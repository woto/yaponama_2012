$(document).on('click', '[data-expandable-link]', function(event) {
  var table;
  event.preventDefault();
  table = $(event.currentTarget).closest('[data-expandable-table]');
  $(event.currentTarget).hide();
  return $(table).find('tr').removeClass('hidden');
});
