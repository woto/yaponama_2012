$(document).on("click", "[window-dialog]", function(event){
  event.preventDefault();
  var params = "width=920,height=730,toolbar=no,directories=no,menubar=no,location=no,resizable=yes,scrollbars=yes,status=no"
  window.open($(event.currentTarget).attr('window-dialog'), "Авториф", params)
});
