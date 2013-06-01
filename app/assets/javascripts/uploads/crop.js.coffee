#= require Jcrop/js/jquery.Jcrop

$ ->
  $('.img-crop').Jcrop
    # keySupport: false
    onChange: showCoords
    onSelect: showCoords
  $('.img-crop').load ->
    $('#upload_image_w').val($('.img-crop').width())
    $('#upload_image_h').val($('.img-crop').height())

showCoords = (coords) ->
  $('#upload_crop_x').val(coords.x)
  $('#upload_crop_y').val(coords.y)
  $('#upload_crop_w').val(coords.w)
  $('#upload_crop_h').val(coords.h)
