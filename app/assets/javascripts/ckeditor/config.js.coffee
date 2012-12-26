CKEDITOR.editorConfig = (config) ->
  #config.removeButtons = 'Anchor,Underline,Strike,Subscript,Superscript';
  config.height = 300;
  #config.plugins = 'forms'
  config.extraPlugins = 'timestamp,abbr';
  config.plugins = 'about,a11yhelp,basicstyles,bidi,blockquote,clipboard,colorbutton,colordialog,contextmenu,div,elementspath,enterkey,entities,filebrowser,find,flash,floatingspace,font,format,horizontalrule,htmlwriter,image,iframe,indent,justify,link,list,liststyle,magicline,maximize,newpage,pagebreak,pastefromword,pastetext,preview,print,removeformat,resize,save,selectall,showblocks,showborders,smiley,sourcearea,specialchar,stylescombo,tab,table,tabletools,templates,toolbar,undo,wysiwygarea';

  config.toolbarGroups = [
    { name: 'document',	   groups: [ 'mode', 'document', 'doctools' ] },
    { name: 'clipboard',   groups: [ 'clipboard', 'undo' ] },
    { name: 'editing',     groups: [ 'find', 'selection', 'spellchecker' ] },
    { name: 'forms' },
    '/',
    { name: 'basicstyles', groups: [ 'basicstyles', 'cleanup' ] },
    { name: 'paragraph',   groups: [ 'list', 'indent', 'blocks', 'align' ] },
    { name: 'links' },
    { name: 'insert' },
    '/',
    { name: 'styles' },
    { name: 'colors' },
    { name: 'tools' },
    { name: 'others' },
    { name: 'about' }

    config.filebrowserBrowseUrl = '/browser/browse/type/all';
    #config.filebrowserUploadUrl = '/browser/upload/type/all';
    config.filebrowserImageBrowseUrl = '/admin/uploads';
    #config.filebrowserImageUploadUrl = '/admin/uploads';
    config.filebrowserWindowWidth  = 700;
    config.filebrowserWindowHeight = 600;
  ]
