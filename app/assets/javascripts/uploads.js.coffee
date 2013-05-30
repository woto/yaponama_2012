#= require jQuery-File-Upload/js/jquery.iframe-transport
#= require jQuery-File-Upload/js/jquery.fileupload

#= require jquery.transit/jquery.transit
#= require Jcrop/js/jquery.Jcrop

# ROTATE
$(document).on 'click', '.img-rotate', ->
  angle = $(this).data('angle')

  if angle?
    angle += 90
  else 
    angle = 90

  $(this).data('angle', angle);
  $(this).transition rotate: angle


# CROP
$ ->
  $('.img-crop').Jcrop
    keySupport: false


# UPLOAD
$ ->
  "use strict"
  
  # Change this to the location of your server-side upload handler:
  $("#fileupload").fileupload
    url: "/uploads"
    dataType: "json"
    done: (e, data) ->
      $.each data.result.files, (index, file) ->
        $("<p/>").text(file.name).appendTo "#uploads"


    progressall: (e, data) ->
      progress = parseInt(data.loaded / data.total * 100, 10)
      $("#progress .bar").css "width", progress + "%"

  $("#fileupload").fileupload "option",
    paramName: "upload[upload]"
