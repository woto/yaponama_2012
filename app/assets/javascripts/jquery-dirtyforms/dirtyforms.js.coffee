$ ->
  window.initDirtyForms()

window.initDirtyForms = ->
  $.DirtyForms.message = "Некоторые данные были изменены. Вы уверены, что хотите продолжить без сохранения?"
  $.DirtyForms.title = "Имеются не сохраненные данные"
  #$.DirtyForms.debug = true

  $.DirtyForms.dialog =
    close: ->
      $("#confirm").modal "hide"

    refire: (content, ev) ->
      
      # Launch twitter modal here
      $("#confirm").modal "show"

    fire: (message, title) ->
      
      # Launch twitter modal here
      content = '<div id="confirm" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="confirm-label" aria-hidden="true"> <div class="modal-header"> <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button> <h3 id="confirm-label">' + title + '</h3> </div> <div class="modal-body"> <p>' + message + '</p> </div> <div class="modal-footer"> <button class="btn ignoredirty cancel" data-dismiss="modal" aria-hidden="true">Отменить</button> <button class="btn btn-primary ignoredirty continue">Продолжить</button> </div> </div>'
      $("body").append content
      $("#confirm").modal "show"

    bind: ->
      $("#confirm").on "hidden", $.DirtyForms.decidingCancel
      $("#confirm .cancel").click $.DirtyForms.decidingCancel
      $("#confirm .continue").click $.DirtyForms.decidingContinue
      false

    # Close Twitter Modal here
    stash: ->
      fb = $("#confirm")
      (if ($.trim(fb.html()) is "" or fb.css("display") isnt "block") then false else $("#confirm .modal-body").clone(true))

    selector: "#confirm .modal-body"

  $("form.dirtyforms").dirtyForms()

  $(document).on 'dirty.dirtyforms', (event, element) ->
    #$(element).attr('style', 'border: 1px solid black')
    #for dirty in $(':dirty')
    $(element).closest('.control-group').attr('style', 'background: #ffe');

  window.initCkeditorHelper()
