CKEDITOR.dialog.add("docProps",function(t){function e(e,i){var n=function(){o(this),i(this,this._.parentDialog)},o=function(t){t.removeListener("ok",n),t.removeListener("cancel",o)},a=function(t){t.on("ok",n),t.on("cancel",o)};t.execCommand(e),t._.storedDialogs.colordialog?a(t._.storedDialogs.colordialog):CKEDITOR.on("dialogDefinition",function(t){if(t.data.name==e){var i=t.data.definition;t.removeListener(),i.onLoad=CKEDITOR.tools.override(i.onLoad,function(t){return function(){a(this),i.onLoad=t,"function"==typeof t&&t.call(this)}})}})}function i(){var t=this.getDialog().getContentElement("general",this.id+"Other");t&&("other"==this.getValue()?(t.getInputElement().removeAttribute("readOnly"),t.focus(),t.getElement().removeClass("cke_disabled")):(t.getInputElement().setAttribute("readOnly",!0),t.getElement().addClass("cke_disabled")))}function n(e,i,n){return function(o,a,l){a=c,o="undefined"!=typeof n?n:this.getValue(),!o&&e in a?a[e].remove():o&&e in a?a[e].setAttribute("content",o):o&&(a=new CKEDITOR.dom.element("meta",t.document),a.setAttribute(i?"http-equiv":"name",e),a.setAttribute("content",o),l.append(a))}}function o(t,e){return function(){var i=c,i=t in i?i[t].getAttribute("content")||"":"";return e?i:(this.setValue(i),null)}}function a(t){return function(e,i,n,o){o.removeAttribute("margin"+t),e=this.getValue(),""!==e?o.setStyle("margin-"+t,CKEDITOR.tools.cssLength(e)):o.removeStyle("margin-"+t)}}function l(t,e,i){t.removeStyle(e),t.getComputedStyle(e)!=i&&t.setStyle(e,i)}var r=t.lang.docprops,s=t.lang.common,c={},g=function(t,i,n){return{type:"hbox",padding:0,widths:["60%","40%"],children:[CKEDITOR.tools.extend({type:"text",id:t,label:r[i]},n||{},1),{type:"button",id:t+"Choose",label:r.chooseColor,className:"colorChooser",onClick:function(){var i=this;e("colordialog",function(e){var n=i.getDialog();n.getContentElement(n._.currentTabId,t).setValue(e.getContentElement("picker","selectedColor").getValue())})}}]}},h="javascript:void((function(){"+encodeURIComponent("document.open();"+(CKEDITOR.env.ie?"("+CKEDITOR.tools.fixDomain+")();":"")+'document.write( \'<html style="background-color: #ffffff; height: 100%"><head></head><body style="width: 100%; height: 100%; margin: 0px">'+r.previewHtml+"</body></html>' );document.close();")+"})())";return{title:r.title,minHeight:330,minWidth:500,onShow:function(){for(var e=t.document,i=e.getElementsByTag("html").getItem(0),n=e.getHead(),o=e.getBody(),a={},l=e.getElementsByTag("meta"),r=l.count(),s=0;r>s;s++){var g=l.getItem(s);a[g.getAttribute(g.hasAttribute("http-equiv")?"http-equiv":"name").toLowerCase()]=g}c=a,this.setupContent(e,i,n,o)},onHide:function(){c={}},onOk:function(){var e=t.document,i=e.getElementsByTag("html").getItem(0),n=e.getHead(),o=e.getBody();this.commitContent(e,i,n,o)},contents:[{id:"general",label:s.generalTab,elements:[{type:"text",id:"title",label:r.docTitle,setup:function(t){this.setValue(t.getElementsByTag("title").getItem(0).data("cke-title"))},commit:function(t,e,i,n,o){o||t.getElementsByTag("title").getItem(0).data("cke-title",this.getValue())}},{type:"hbox",children:[{type:"select",id:"dir",label:s.langDir,style:"width: 100%",items:[[s.notSet,""],[s.langDirLtr,"ltr"],[s.langDirRtl,"rtl"]],setup:function(t,e,i,n){this.setValue(n.getDirection()||"")},commit:function(t,e,i,n){(t=this.getValue())?n.setAttribute("dir",t):n.removeAttribute("dir"),n.removeStyle("direction")}},{type:"text",id:"langCode",label:s.langCode,setup:function(t,e){this.setValue(e.getAttribute("xml:lang")||e.getAttribute("lang")||"")},commit:function(t,e,i,n,o){o||((t=this.getValue())?e.setAttributes({"xml:lang":t,lang:t}):e.removeAttributes({"xml:lang":1,lang:1}))}}]},{type:"hbox",children:[{type:"select",id:"charset",label:r.charset,style:"width: 100%",items:[[s.notSet,""],[r.charsetASCII,"us-ascii"],[r.charsetCE,"iso-8859-2"],[r.charsetCT,"big5"],[r.charsetCR,"iso-8859-5"],[r.charsetGR,"iso-8859-7"],[r.charsetJP,"iso-2022-jp"],[r.charsetKR,"iso-2022-kr"],[r.charsetTR,"iso-8859-9"],[r.charsetUN,"utf-8"],[r.charsetWE,"iso-8859-1"],[r.other,"other"]],"default":"",onChange:function(){this.getDialog().selectedCharset="other"!=this.getValue()?this.getValue():"",i.call(this)},setup:function(){this.metaCharset="charset"in c;var t=o(this.metaCharset?"charset":"content-type",1,1).call(this);if(!this.metaCharset&&t.match(/charset=[^=]+$/)&&(t=t.substring(t.indexOf("=")+1)),t){if(this.setValue(t.toLowerCase()),!this.getValue()){this.setValue("other");var e=this.getDialog().getContentElement("general","charsetOther");e&&e.setValue(t)}this.getDialog().selectedCharset=t}i.call(this)},commit:function(t,e,i,o,a){a||(o=this.getValue(),a=this.getDialog().getContentElement("general","charsetOther"),"other"==o&&(o=a?a.getValue():""),o&&!this.metaCharset&&(o=(c["content-type"]?c["content-type"].getAttribute("content").split(";")[0]:"text/html")+"; charset="+o),n(this.metaCharset?"charset":"content-type",1,o).call(this,t,e,i))}},{type:"text",id:"charsetOther",label:r.charsetOther,onChange:function(){this.getDialog().selectedCharset=this.getValue()}}]},{type:"hbox",children:[{type:"select",id:"docType",label:r.docType,style:"width: 100%",items:[[s.notSet,""],["XHTML 1.1",'<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">'],["XHTML 1.0 Transitional",'<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">'],["XHTML 1.0 Strict",'<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">'],["XHTML 1.0 Frameset",'<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">'],["HTML 5","<!DOCTYPE html>"],["HTML 4.01 Transitional",'<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">'],["HTML 4.01 Strict",'<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">'],["HTML 4.01 Frameset",'<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Frameset//EN" "http://www.w3.org/TR/html4/frameset.dtd">'],["HTML 3.2",'<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">'],["HTML 2.0",'<!DOCTYPE HTML PUBLIC "-//IETF//DTD HTML//EN">'],[r.other,"other"]],onChange:i,setup:function(){if(t.docType&&(this.setValue(t.docType),!this.getValue())){this.setValue("other");var e=this.getDialog().getContentElement("general","docTypeOther");e&&e.setValue(t.docType)}i.call(this)},commit:function(e,i,n,o,a){a||(e=this.getValue(),i=this.getDialog().getContentElement("general","docTypeOther"),t.docType="other"==e?i?i.getValue():"":e)}},{type:"text",id:"docTypeOther",label:r.docTypeOther}]},{type:"checkbox",id:"xhtmlDec",label:r.xhtmlDec,setup:function(){this.setValue(!!t.xmlDeclaration)},commit:function(e,i,n,o,a){a||(this.getValue()?(t.xmlDeclaration='<?xml version="1.0" encoding="'+(this.getDialog().selectedCharset||"utf-8")+'"?>',i.setAttribute("xmlns","http://www.w3.org/1999/xhtml")):(t.xmlDeclaration="",i.removeAttribute("xmlns")))}}]},{id:"design",label:r.design,elements:[{type:"hbox",widths:["60%","40%"],children:[{type:"vbox",children:[g("txtColor","txtColor",{setup:function(t,e,i,n){this.setValue(n.getComputedStyle("color"))},commit:function(t,e,i,n,o){(this.isChanged()||o)&&(n.removeAttribute("text"),(t=this.getValue())?n.setStyle("color",t):n.removeStyle("color"))}}),g("bgColor","bgColor",{setup:function(t,e,i,n){t=n.getComputedStyle("background-color")||"",this.setValue("transparent"==t?"":t)},commit:function(t,e,i,n,o){(this.isChanged()||o)&&(n.removeAttribute("bgcolor"),(t=this.getValue())?n.setStyle("background-color",t):l(n,"background-color","transparent"))}}),{type:"hbox",widths:["60%","40%"],padding:1,children:[{type:"text",id:"bgImage",label:r.bgImage,setup:function(t,e,i,n){t=n.getComputedStyle("background-image")||"",t="none"==t?"":t.replace(/url\(\s*(["']?)\s*([^\)]*)\s*\1\s*\)/i,function(t,e,i){return i}),this.setValue(t)},commit:function(t,e,i,n){n.removeAttribute("background"),(t=this.getValue())?n.setStyle("background-image","url("+t+")"):l(n,"background-image","none")}},{type:"button",id:"bgImageChoose",label:s.browseServer,style:"display:inline-block;margin-top:10px;",hidden:!0,filebrowser:"design:bgImage"}]},{type:"checkbox",id:"bgFixed",label:r.bgFixed,setup:function(t,e,i,n){this.setValue("fixed"==n.getComputedStyle("background-attachment"))},commit:function(t,e,i,n){this.getValue()?n.setStyle("background-attachment","fixed"):l(n,"background-attachment","scroll")}}]},{type:"vbox",children:[{type:"html",id:"marginTitle",html:'<div style="text-align: center; margin: 0px auto; font-weight: bold">'+r.margin+"</div>"},{type:"text",id:"marginTop",label:r.marginTop,style:"width: 80px; text-align: center",align:"center",inputStyle:"text-align: center",setup:function(t,e,i,n){this.setValue(n.getStyle("margin-top")||n.getAttribute("margintop")||"")},commit:a("top")},{type:"hbox",children:[{type:"text",id:"marginLeft",label:r.marginLeft,style:"width: 80px; text-align: center",align:"center",inputStyle:"text-align: center",setup:function(t,e,i,n){this.setValue(n.getStyle("margin-left")||n.getAttribute("marginleft")||"")},commit:a("left")},{type:"text",id:"marginRight",label:r.marginRight,style:"width: 80px; text-align: center",align:"center",inputStyle:"text-align: center",setup:function(t,e,i,n){this.setValue(n.getStyle("margin-right")||n.getAttribute("marginright")||"")},commit:a("right")}]},{type:"text",id:"marginBottom",label:r.marginBottom,style:"width: 80px; text-align: center",align:"center",inputStyle:"text-align: center",setup:function(t,e,i,n){this.setValue(n.getStyle("margin-bottom")||n.getAttribute("marginbottom")||"")},commit:a("bottom")}]}]}]},{id:"meta",label:r.meta,elements:[{type:"textarea",id:"metaKeywords",label:r.metaKeywords,setup:o("keywords"),commit:n("keywords")},{type:"textarea",id:"metaDescription",label:r.metaDescription,setup:o("description"),commit:n("description")},{type:"text",id:"metaAuthor",label:r.metaAuthor,setup:o("author"),commit:n("author")},{type:"text",id:"metaCopyright",label:r.metaCopyright,setup:o("copyright"),commit:n("copyright")}]},{id:"preview",label:s.preview,elements:[{type:"html",id:"previewHtml",html:'<iframe src="'+h+'" style="width: 100%; height: 310px" hidefocus="true" frameborder="0" id="cke_docProps_preview_iframe"></iframe>',onLoad:function(){this.getDialog().on("selectPage",function(t){if("preview"==t.data.page){var e=this;setTimeout(function(){var t=CKEDITOR.document.getById("cke_docProps_preview_iframe").getFrameDocument(),i=t.getElementsByTag("html").getItem(0),n=t.getHead(),o=t.getBody();e.commitContent(t,i,n,o,1)},50)}}),CKEDITOR.document.getById("cke_docProps_preview_iframe").getAscendant("table").setStyle("height","100%")}}]}]}});