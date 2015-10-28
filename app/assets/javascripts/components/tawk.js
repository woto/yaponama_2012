$(function(){
  $(document).on('click', '.talk-show', function(event){
    event.preventDefault();
    Tawk_API.popup();
  })
})
