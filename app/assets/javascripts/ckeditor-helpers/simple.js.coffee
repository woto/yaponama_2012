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
          plugins: 'about,basicstyles,clipboard,floatingspace,list,indent,enterkey,entities,link,pastetext,toolbar,undo,wysiwygarea',
		
          toolbarGroups: [
            { name: 'document',	   groups: [ 'mode', 'document', 'doctools' ] },
            { name: 'editing',     groups: [ 'find', 'selection', 'spellchecker' ] },
            { name: 'forms' },
            { name: 'basicstyles', groups: [ 'basicstyles', 'cleanup' ] },
            { name: 'paragraph',   groups: [ 'list', 'indent', 'blocks', 'align' ] },
            { name: 'links' },
            { name: 'insert' },
            { name: 'styles' },
            { name: 'colors' },
            { name: 'tools' },
            { name: 'others' },
          ],

          removeButtons: 'Anchor,Underline,Strike,Subscript,Superscript',
          forcePasteAsPlainText: true,
          removeDialogTabs: 'link:advanced',
          height: 150,
          extraPlugins: 'divarea',
        })

        root = exports ? window # http://stackoverflow.com/questions/4214731/coffeescript-global-variables
        if root? && root.DirtyForms?
          dirtyforms = new root.DirtyForms.get
          dirtyforms.lazy_added_ckeditor(tmp_ckeditor)
