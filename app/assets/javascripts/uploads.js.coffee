#= require jQuery-File-Upload/js/vendor/jquery.ui.widget.js
#= require jQuery-File-Upload/js/jquery.iframe-transport
#= require jQuery-File-Upload/js/jquery.fileupload

App = exports ? this

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
App.init_jquery_file_upload = ->
  "use strict"

  # Change this to the location of your server-side upload handler:
  $(".fileupload").fileupload
    url: "/uploads"
    dataType: "json"
    done: (e, data) ->

      uploads = $(e.target).closest("[rel='uploads-parent']").find('.uploads')

      $.each data.result.files, (index, upload) ->

        file = ''
        rotate = ''
        crop = ''
        remove = ''

        name =  "<small>" + upload.name + "</small>"

        if upload.image
          file = "<span class='upload'> <a class='image-process' href='" + upload.url + "'>" + name + "<br/> <img src='" + upload.thumbnail_url + "'></a> </span> "
          rotate = '<a class="image-process btn btn-default btn-xs" href="' + upload.rotate_url + '"> <i class="fa fa-rotate-right"></i></a> '
          crop = '<a class="image-process btn btn-default btn-xs" href="' + upload.crop_url + '"> <i class="fa fa-crop"></i></a> '
        else
          file = '<span class="upload"> <a class="image-process" href="' + upload.url + '">' + name + '</a> </span>'

        remove = '<a class="btn btn-default btn-xs" href="' + '#' + '"> <i class="fa fa-times"></i></a> '

        $("<p class='pull-left well well-sm' style='margin: 5px; background: #FFF'/>").html(file + '<div class="btn-group-vertical">' + rotate + crop + remove + '</div>').appendTo uploads

    start: ->
      $('#insert_files_into_ckeditor').hide()

    progressall: (e, data) ->
      $('#insert_files_into_ckeditor').show()

  $(".fileupload").fileupload "option",
    paramName: "upload[upload]"

$ ->
  App.init_jquery_file_upload()

