var value = 0

$(document).ready(function() {
  $('body').on('click', '.img-rotate', function(){
    angle = $(this).data('angle')
    console.log(angle);
    if( typeof angle != 'undefined' )
    {
      $(this).data('angle', angle + 90);
    }
    else 
    {
      angle = 90
      $(this).data('angle', angle);
    }

    $(this).rotate({ animateTo:angle});
  })
})
