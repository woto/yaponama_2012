!function(){CKEDITOR.plugins.add("div",{requires:"dialog",lang:"af,ar,bg,bn,bs,ca,cs,cy,da,de,el,en,en-au,en-ca,en-gb,eo,es,et,eu,fa,fi,fo,fr,fr-ca,gl,gu,he,hi,hr,hu,id,is,it,ja,ka,km,ko,ku,lt,lv,mk,mn,ms,nb,nl,no,pl,pt,pt-br,ro,ru,si,sk,sl,sq,sr,sr-latn,sv,th,tr,ug,uk,vi,zh,zh-cn",icons:"creatediv",hidpi:!0,init:function(e){if(!e.blockless){var d=e.lang.div,i="div(*)";CKEDITOR.dialog.isTabEnabled(e,"editdiv","advanced")&&(i+=";div[dir,id,lang,title]{*}"),e.addCommand("creatediv",new CKEDITOR.dialogCommand("creatediv",{allowedContent:i,requiredContent:"div",contextSensitive:!0,refresh:function(e,d){this.setState("div"in(e.config.div_wrapTable?d.root:d.blockLimit).getDtd()?CKEDITOR.TRISTATE_OFF:CKEDITOR.TRISTATE_DISABLED)}})),e.addCommand("editdiv",new CKEDITOR.dialogCommand("editdiv",{requiredContent:"div"})),e.addCommand("removediv",{requiredContent:"div",exec:function(e){function d(d){(d=CKEDITOR.plugins.div.getSurroundDiv(e,d))&&!d.data("cke-div-added")&&(o.push(d),d.data("cke-div-added"))}for(var i,t=e.getSelection(),a=t&&t.getRanges(),n=t.createBookmarks(),o=[],r=0;r<a.length;r++)i=a[r],i.collapsed?d(t.getStartElement()):(i=new CKEDITOR.dom.walker(i),i.evaluator=d,i.lastForward());for(r=0;r<o.length;r++)o[r].remove(!0);t.selectBookmarks(n)}}),e.ui.addButton&&e.ui.addButton("CreateDiv",{label:d.toolbar,command:"creatediv",toolbar:"blocks,50"}),e.addMenuItems&&(e.addMenuItems({editdiv:{label:d.edit,command:"editdiv",group:"div",order:1},removediv:{label:d.remove,command:"removediv",group:"div",order:5}}),e.contextMenu&&e.contextMenu.addListener(function(d){return!d||d.isReadOnly()?null:CKEDITOR.plugins.div.getSurroundDiv(e)?{editdiv:CKEDITOR.TRISTATE_OFF,removediv:CKEDITOR.TRISTATE_OFF}:null})),CKEDITOR.dialog.add("creatediv",this.path+"dialogs/div.js"),CKEDITOR.dialog.add("editdiv",this.path+"dialogs/div.js")}}}),CKEDITOR.plugins.div={getSurroundDiv:function(e,d){var i=e.elementPath(d);return e.elementPath(i.blockLimit).contains("div",1)}}}();