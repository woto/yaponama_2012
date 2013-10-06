#= require jQuery-File-Upload/js/jquery.iframe-transport
#= require jQuery-File-Upload/js/jquery.fileupload

# Обработка изображений (crop, rotate)
$(document).on 'click', '.image-process', (event) ->
  event.preventDefault()
  image_process = window.open( $(this).attr('href'), "image_process", "scrollbars=yes, resizable=yes, width=500, height=500")

$(document).on 'click', '#insert_files_into_ckeditor', ->
  text = $(".upload").map( (i, element) ->
    $(element).html()
  )
  text = '<p>' + text.get().join('</p><p>') + '</p><p></p>'
  editor = $('#ckeditor-name').text()
  window.opener.CKEDITOR.instances[editor].insertHtml(text)
  window.close()



# UPLOAD
$ ->
  "use strict"

  # Change this to the location of your server-side upload handler:
  $("#fileupload").fileupload
    url: "/uploads"
    dataType: "json"
    done: (e, data) ->
      $.each data.result.files, (index, upload) ->

        file = ''
        rotate = ''
        crop = ''

        if upload.image
          file = "<span class='upload'> <a class='image-process' href='" + upload.url + "'><img src='" + upload.thumbnail_url + "'></a> </span> "
          rotate = '<a class="image-process btn btn-default" href="' + upload.rotate_url + '"> <i class="icon icon-rotate-right"></i> Повернуть </a> '
          crop = '<a class="image-process btn btn-default" href="' + upload.crop_url + '"> <i class="icon icon-crop"></i> Обрезать </a> '
        else
          file = '<span class="upload"> <a class="image-process" href="' + upload.url + '">' + upload.name + '</a> </span>'

        $("<p/>").html(file + '<div class="btn-group-vertical">' + rotate + crop + '</div>').appendTo "#uploads"

        #$("<p/>").text(file.name).appendTo "#uploads"

    start: ->
      $('#insert_files_into_ckeditor').hide()

    progressall: (e, data) ->
      $('#insert_files_into_ckeditor').show()

  $("#fileupload").fileupload "option",
    paramName: "upload[upload]"
