!function(){function e(e,n,i){if(!e.getCustomData("indent_processed")){var s=this.editor,r=this.isIndent;if(n){if(s=e.$.className.match(this.classNameRegex),i=0,s&&(s=s[1],i=CKEDITOR.tools.indexOf(n,s)+1),0>(i+=r?1:-1))return;i=Math.min(i,n.length),i=Math.max(i,0),e.$.className=CKEDITOR.tools.ltrim(e.$.className.replace(this.classNameRegex,"")),i>0&&e.addClass(n[i-1])}else{var n=t(e,i),i=parseInt(e.getStyle(n),10),a=s.config.indentOffset||40;if(isNaN(i)&&(i=0),i+=(r?1:-1)*a,0>i)return;i=Math.max(i,0),i=Math.ceil(i/a)*a,e.setStyle(n,i?i+(s.config.indentUnit||"px"):""),""===e.getAttribute("style")&&e.removeAttribute("style")}CKEDITOR.dom.element.setMarker(this.database,e,"indent_processed",1)}}function t(e,t){return"ltr"==(t||e.getComputedStyle("direction"))?"margin-left":"margin-right"}var n=CKEDITOR.dtd.$listItem,i=CKEDITOR.dtd.$list,s=CKEDITOR.TRISTATE_DISABLED,r=CKEDITOR.TRISTATE_OFF;CKEDITOR.plugins.add("indentblock",{requires:"indent",init:function(a){function l(){o.specificDefinition.apply(this,arguments),this.allowedContent={"div h1 h2 h3 h4 h5 h6 ol p pre ul":{propertiesOnly:!0,styles:c?null:"margin-left,margin-right",classes:c||null}},this.enterBr&&(this.allowedContent.div=!0),this.requiredContent=(this.enterBr?"div":"p")+(c?"("+c.join(",")+")":"{margin-left}"),this.jobs={20:{refresh:function(e,i){var a=i.block||i.blockLimit;if(a.is(n))a=a.getParent();else if(a.getAscendant(n))return s;if(!this.enterBr&&!this.getContext(i))return s;if(c){var l;l=c;var a=a.$.className.match(this.classNameRegex),o=this.isIndent;return l=a?o?a[1]!=l.slice(-1):!0:o,l?r:s}return this.isIndent?r:a?CKEDITOR[(parseInt(a.getStyle(t(a)),10)||0)<=0?"TRISTATE_DISABLED":"TRISTATE_OFF"]:s},exec:function(t){var n,s=t.getSelection(),s=s&&s.getRanges(1)[0];if(n=t.elementPath().contains(i))e.call(this,n,c);else for(s=s.createIterator(),t=t.config.enterMode,s.enforceRealBlocks=!0,s.enlargeBr=t!=CKEDITOR.ENTER_BR;n=s.getNextParagraph(t==CKEDITOR.ENTER_P?"p":"div");)e.call(this,n,c);return!0}}}}var o=CKEDITOR.plugins.indent,c=a.config.indentClasses;o.registerCommands(a,{indentblock:new l(a,"indentblock",!0),outdentblock:new l(a,"outdentblock")}),CKEDITOR.tools.extend(l.prototype,o.specificDefinition.prototype,{context:{div:1,dl:1,h1:1,h2:1,h3:1,h4:1,h5:1,h6:1,ul:1,ol:1,p:1,pre:1,table:1},classNameRegex:c?RegExp("(?:^|\\s+)("+c.join("|")+")(?=$|\\s)"):null})}})}();