$(function(){
  $('#products .icheck input').iCheck({
    checkboxClass: 'icheckbox_square-green',
    radioClass: 'iradio_square-green',
    inheritID: true
  });
});

$(function(){
  $('#products .gallery').each(function() {
      $(this).magnificPopup({
          delegate: 'a',
          type: 'image',
          gallery: {
            enabled: true
          }
      });
  });
})
