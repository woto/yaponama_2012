root = exports ? window # http://stackoverflow.com/questions/4214731/coffeescript-global-variables

window.simple_options = ->
  # Без указания plugins к нему так же цепляется inline
  plugins: 'basicstyles,list,link,pastetext,toolbar,undo,save',
  toolbar: [
      { name: 'basicstyles', items: [ 'Bold', 'Italic' ] },
      { name: 'links', items: [ 'Link', 'Unlink' ] },
      { name: 'paragraph', groups: [ 'list'], items: [ 'NumberedList' ] },
      ['Upload']
    ],
  forcePasteAsPlainText: true,
  height: 'auto',
  extraPlugins: 'divarea,autogrow,upload',
  removePlugins: 'resize',
  keystrokes: [ [ CKEDITOR.CTRL + 13, 'save' ] ]
