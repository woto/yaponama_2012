CKEDITOR.plugins.add("uicolor",{requires:"dialog",lang:"bg,cs,cy,da,de,el,en,eo,et,fa,fi,fr,he,hr,it,ku,mk,nb,nl,no,pl,tr,ug,uk,vi,zh-cn",icons:"uicolor",hidpi:!0,init:function(o){CKEDITOR.env.ie6Compat||(o.addCommand("uicolor",new CKEDITOR.dialogCommand("uicolor")),o.ui.addButton&&o.ui.addButton("UIColor",{label:o.lang.uicolor.title,command:"uicolor",toolbar:"tools,1"}),CKEDITOR.dialog.add("uicolor",this.path+"dialogs/uicolor.js"),CKEDITOR.scriptLoader.load(CKEDITOR.getUrl("plugins/uicolor/yui/yui.js")),CKEDITOR.document.appendStyleSheet(CKEDITOR.getUrl("plugins/uicolor/yui/assets/yui.css")))}});