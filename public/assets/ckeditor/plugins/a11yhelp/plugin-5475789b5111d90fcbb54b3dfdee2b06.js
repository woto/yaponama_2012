!function(){CKEDITOR.plugins.add("a11yhelp",{requires:"dialog",availableLangs:{ar:1,bg:1,ca:1,cs:1,cy:1,da:1,de:1,el:1,en:1,eo:1,es:1,et:1,fa:1,fi:1,fr:1,"fr-ca":1,gl:1,gu:1,he:1,hi:1,hr:1,hu:1,id:1,it:1,ja:1,km:1,ku:1,lt:1,lv:1,mk:1,mn:1,nb:1,nl:1,no:1,pl:1,pt:1,"pt-br":1,ro:1,ru:1,si:1,sk:1,sl:1,sq:1,sr:1,"sr-latn":1,sv:1,th:1,tr:1,ug:1,uk:1,vi:1,"zh-cn":1},init:function(a){var e=this;a.addCommand("a11yHelp",{exec:function(){var l=a.langCode,l=e.availableLangs[l]?l:e.availableLangs[l.replace(/-.*/,"")]?l.replace(/-.*/,""):"en";CKEDITOR.scriptLoader.load(CKEDITOR.getUrl(e.path+"dialogs/lang/"+l+".js"),function(){a.lang.a11yhelp=e.langEntries[l],a.openDialog("a11yHelp")})},modes:{wysiwyg:1,source:1},readOnly:1,canUndo:!1}),a.setKeystroke(CKEDITOR.ALT+48,"a11yHelp"),CKEDITOR.dialog.add("a11yHelp",this.path+"dialogs/a11yhelp.js")}})}();