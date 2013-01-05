# http://peterpetrik.com/blog/remove-tabs-and-elements-from-ckeditor-dialog-window

$ ->
  window.initSimpleCkeditor()

$(window).bind "page:change", ->
  window.initSimpleCkeditor()

window.initSimpleCkeditor = ->
  for ckeditor, i in $('.ckeditor-simple')
    CKEDITOR.replace(ckeditor, {
      removeButtons: 'Anchor,Underline,Strike,Subscript,Superscript,Flash,Table,Rule,HorizontalRule',
      height: 150,
      #plugins: 'forms'
      plugins: 'basicstyles,resize,clipboard,enterkey,font,pastetext,horizontalrule,image,link,list,removeformat,toolbar,wysiwygarea',

      forcePasteAsPlainText: true,
      linkShowAdvancedTab: false; 
      linkShowTargetTab: false; 


      toolbarGroups: [
        name: "forms"
      , "/",
        name: "basicstyles"
        groups: ["basicstyles"]
      ,
        name: "paragraph"
        groups: ["list"]
      ,
        name: "links"
      ,
        name: "insert"
      ]
    })

    #ck.on 'paste', (e) ->
      #e.editor.setData(e.editor.execCommand( 'removeFormat', e.editor.selection ));
      #e.editor.setData(ck.execCommand( 'removeFormat', e.data.dataValue ))
       
    CKEDITOR.on "dialogDefinition", (ev) ->
      if ev.editor.name == 'ckeditor-simple'
        dialogName = ev.data.name
        dialogDefinition = ev.data.definition

        if dialogName is "link"
          dialogDefinition.onShow = ->
            dialog = CKEDITOR.dialog.getCurrent()

            #dialog.hidePage( 'target' );
            #dialog.hidePage( 'advanced' );

            elem = dialog.getContentElement("info", "anchorOptions")
            elem.getElement().hide()
            elem = dialog.getContentElement("info", "emailOptions")
            elem.getElement().hide()
            elem = dialog.getContentElement("info", "linkType")
            elem.getElement().hide()
            elem = dialog.getContentElement("info", "protocol")
            elem.disable()

