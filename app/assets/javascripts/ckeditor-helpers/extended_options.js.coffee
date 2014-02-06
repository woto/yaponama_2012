root = exports ? window # http://stackoverflow.com/questions/4214731/coffeescript-global-variables

window.extended_options =
  allowedContent: true
  #removeButtons: 'Anchor,Underline,Strike,Subscript,Superscript';
  height: 400
  #plugins: 'forms'
  extraPlugins: 'timestamp,abbr,divarea,codemirror,oembed,image2,upload'
  plugins: 'about,a11yhelp,basicstyles,bidi,blockquote,clipboard,colorbutton,colordialog,contextmenu,div,elementspath,enterkey,entities,filebrowser,find,flash,floatingspace,font,format,horizontalrule,htmlwriter,indent,justify,link,list,liststyle,magicline,maximize,newpage,pagebreak,pastefromword,pastetext,preview,print,removeformat,resize,save,selectall,showblocks,showborders,smiley,sourcearea,specialchar,stylescombo,tab,table,tabletools,templates,toolbar,undo,wysiwygarea'
  removePlugins: 'image,forms'
  toolbarGroups: [
    name: "document"
    groups: ["mode", "document", "doctools"]
  ,
    name: "clipboard"
    groups: ["clipboard", "undo"]
  ,
    name: "editing"
    groups: ["find", "selection", "spellchecker"]
  ,
    name: "forms"
  , "/",
    name: "basicstyles"
    groups: ["basicstyles", "cleanup"]
  ,
    name: "paragraph"
    groups: ["list", "indent", "blocks", "align"]
  ,
    name: "links"
  ,
    name: "insert"
  , "/",
    name: "styles"
  ,
    name: "colors"
  ,
    name: "tools"
  ,
    name: "others"
  ,
    name: "about"
  ,
    name: "oembed"
  ]

  filebrowserBrowseUrl: '/browser/browse/type/all';
  #filebrowserUploadUrl: '/browser/upload/type/all';
  filebrowserImageBrowseUrl: '/admin/uploads';
  #filebrowserImageUploadUrl: '/admin/uploads';
  filebrowserWindowWidth: 700;
  filebrowserWindowHeight: 350;


#CKEDITOR.on "dialogDefinition", (ev) ->
#  
#  # Take the dialog name and its definition from the event data. 
#  dialogName = ev.data.name
#  dialogDefinition = ev.data.definition
#  
#  #var dialog = CKEDITOR.dialog.getCurrent(); 
#  #alert( dialog.getName() ); 
#  
#  # Check if the definition is from the dialog we are interested in (the 'link' dialog) 
#  if dialogName is "link"
#    dialogDefinition.onShow = ->
#      dialog = CKEDITOR.dialog.getCurrent()
#      
#      #dialog.hidePage( 'target' ); // now via config 
#      #dialog.hidePage( 'advanced' ); // now via config 
#      elem = dialog.getContentElement("info", "anchorOptions")
#      elem.getElement().hide()
#      elem = dialog.getContentElement("info", "emailOptions")
#      elem.getElement().hide()
#      elem = dialog.getContentElement("info", "linkType")
#      elem.getElement().hide()
#      elem = dialog.getContentElement("info", "protocol")
#      elem.disable()
#  
#  # if you have any plugin of your own and need to remove ok button 
#  #    else if(dialogName == 'my_own_plugin') { 
#  #        // remove ok button (this was hard to find!) 
#  #        dialogDefinition.onShow = function () { 
#  #           // this is a hack 
#  #           document.getElementById(this.getButton('ok').domId).style.display='none'; 
#  #        }; 
#  #    }
#  else if dialogName is "image"
#    
#    # memo: dialogDefinition.onShow = ... throws JS error (C.preview not defined) 
#    
#    # Get a reference to the 'Link Info' tab. 
#    infoTab = dialogDefinition.getContents("info")
#    
#    # Remove unnecessary widgets 
#    infoTab.remove "ratioLock"
#    infoTab.remove "txtHeight"
#    infoTab.remove "txtWidth"
#    infoTab.remove "txtBorder"
#    infoTab.remove "txtHSpace"
#    infoTab.remove "txtVSpace"
#    infoTab.remove "cmbAlign"
#    dialogDefinition.onLoad = ->
#      dialog = CKEDITOR.dialog.getCurrent()
#      elem = dialog.getContentElement("info", "htmlPreview")
#      elem.getElement().hide()
#      dialog.hidePage "Link"
#      dialog.hidePage "advanced"
#      dialog.hidePage "info" # works now (CKEditor v3.6.4)
#      @selectPage "Upload"
#  
#  #var uploadTab = dialogDefinition.getContents('Upload'); 
#  #            var uploadButton = uploadTab.get('uploadButton'); 
#  #            uploadButton['filebrowser']['onSelect'] = function( fileUrl, errorMessage ) { 
#  #                //$("input.cke_dialog_ui_input_text").val(fileUrl); 
#  #                dialog.getContentElement('info', 'txtUrl').setValue(fileUrl); 
#  #                //$(".cke_dialog_ui_button_ok span").click(); 
#  #            }
#  else dialogDefinition.removeContents "advanced"  if dialogName is "table"
#
#
#    dialogName = ev.data.name;
#    dialogDefinition = ev.data.definition;
#
#    if ( dialogName == 'table' )
#      addCssClass = dialogDefinition.getContents('advanced').get('advCSSClasses');
#      addCssClass['default'] = 'table'
#});
# http://stackoverflow.com/questions/7246046/ckeditor-apply-removeformat-on-paste
# http://www.keyvan.net/2012/11/clean-up-html-on-paste-in-ckeditor/
# http://stackoverflow.com/questions/2010335/ckeditor-onpaste-event
# http://fatalweb.com/question/ckeditor-apply-removeformat-on-paste-7246046.html
#
