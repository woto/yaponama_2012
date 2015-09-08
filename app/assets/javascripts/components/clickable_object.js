$(document).on('click', '[data-clickable-object]', function(event) {
  var clickable;
  clickable = $(event.currentTarget).find('[data-clickable-href]');
  if (event.target !== clickable[0]) {
    event.preventDefault();
    $(clickable)[0].click();
  }
});
