$(document).on 'page:load', (e) ->
  window.initSimpleCkeditor()

$ ->
  window.initSimpleCkeditor()

window.initSimpleCkeditor = ->
  placeholders = $('.ckeditor-simple')
  if placeholders.length > 0
    url = "/assets/ckeditor/ckeditor.js"
    $.cachedScript(url).done (script, textStatus) ->
      for ckeditor, i in placeholders
        tmp_ckeditor = CKEDITOR.replace(ckeditor, {
          # Без указания plugins к нему так же цепляется inline
          plugins: 'basicstyles,list,link,pastetext,toolbar,undo,upload,resize',
          toolbar: [
              { name: 'basicstyles', items: [ 'Bold', 'Italic' ] },
              { name: 'links', items: [ 'Link', 'Unlink' ] },
              { name: 'paragraph', groups: [ 'list'], items: [ 'NumberedList' ] },
              ['Upload']
            ],
          forcePasteAsPlainText: true,
          height: 75,
          extraPlugins: 'divarea',
        })

        root = exports ? window # http://stackoverflow.com/questions/4214731/coffeescript-global-variables
        if root? && root.DirtyForms?
          dirtyforms = new root.DirtyForms.get
          dirtyforms.lazy_added_ckeditor(tmp_ckeditor)
