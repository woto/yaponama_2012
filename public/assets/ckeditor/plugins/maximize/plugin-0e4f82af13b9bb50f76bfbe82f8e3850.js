!function(){function e(e){if(!e||e.type!=CKEDITOR.NODE_ELEMENT||"form"!=e.getName())return[];for(var t=[],i=["style","className"],s=0;s<i.length;s++){var n=e.$.elements.namedItem(i[s]);n&&(n=new CKEDITOR.dom.element(n),t.push([n,n.nextSibling]),n.remove())}return t}function t(e,t){if(e&&e.type==CKEDITOR.NODE_ELEMENT&&"form"==e.getName()&&0<t.length)for(var i=t.length-1;i>=0;i--){var s=t[i][0],n=t[i][1];n?s.insertBefore(n):s.appendTo(e)}}function i(i,s){var n=e(i),o={},a=i.$;return s||(o["class"]=a.className||"",a.className=""),o.inline=a.style.cssText||"",s||(a.style.cssText="position: static; overflow: visible"),t(n),o}function s(i,s){var n=e(i),o=i.$;"class"in s&&(o.className=s["class"]),"inline"in s&&(o.style.cssText=s.inline),t(n)}function n(e){if(!e.editable().isInline()){var t,i=CKEDITOR.instances;for(t in i){var s=i[t];"wysiwyg"==s.mode&&!s.readOnly&&(s=s.document.getBody(),s.setAttribute("contentEditable",!1),s.setAttribute("contentEditable",!0))}e.editable().hasFocus&&(e.toolbox.focus(),e.focus())}}CKEDITOR.plugins.add("maximize",{lang:"af,ar,bg,bn,bs,ca,cs,cy,da,de,el,en,en-au,en-ca,en-gb,eo,es,et,eu,fa,fi,fo,fr,fr-ca,gl,gu,he,hi,hr,hu,id,is,it,ja,ka,km,ko,ku,lt,lv,mk,mn,ms,nb,nl,no,pl,pt,pt-br,ro,ru,si,sk,sl,sq,sr,sr-latn,sv,th,tr,ug,uk,vi,zh,zh-cn",icons:"maximize",hidpi:!0,init:function(e){function t(){var t=c.getViewPaneSize();e.resize(t.width,t.height,null,!0)}if(e.elementMode!=CKEDITOR.ELEMENT_MODE_INLINE){var o,a,l,m=e.lang,r=CKEDITOR.document,c=r.getWindow(),d=CKEDITOR.TRISTATE_OFF;e.addCommand("maximize",{modes:{wysiwyg:!CKEDITOR.env.iOS,source:!CKEDITOR.env.iOS},readOnly:1,editorFocus:!1,exec:function(){var u=e.container.getChild(1),T=e.ui.space("contents");if("wysiwyg"==e.mode){var E=e.getSelection();o=E&&E.getRanges(),a=c.getScrollPosition()}else{var g=e.editable().$;o=!CKEDITOR.env.ie&&[g.selectionStart,g.selectionEnd],a=[g.scrollLeft,g.scrollTop]}if(this.state==CKEDITOR.TRISTATE_OFF){for(c.on("resize",t),l=c.getScrollPosition(),E=e.container;E=E.getParent();)E.setCustomData("maximize_saved_styles",i(E)),E.setStyle("z-index",e.config.baseFloatZIndex-5);T.setCustomData("maximize_saved_styles",i(T,!0)),u.setCustomData("maximize_saved_styles",i(u,!0)),T={overflow:CKEDITOR.env.webkit?"":"hidden",width:0,height:0},r.getDocumentElement().setStyles(T),!CKEDITOR.env.gecko&&r.getDocumentElement().setStyle("position","fixed"),(!CKEDITOR.env.gecko||!CKEDITOR.env.quirks)&&r.getBody().setStyles(T),CKEDITOR.env.ie?setTimeout(function(){c.$.scrollTo(0,0)},0):c.$.scrollTo(0,0),u.setStyle("position",CKEDITOR.env.gecko&&CKEDITOR.env.quirks?"fixed":"absolute"),u.$.offsetLeft,u.setStyles({"z-index":e.config.baseFloatZIndex-5,left:"0px",top:"0px"}),u.addClass("cke_maximized"),t(),T=u.getDocumentPosition(),u.setStyles({left:-1*T.x+"px",top:-1*T.y+"px"}),CKEDITOR.env.gecko&&n(e)}else if(this.state==CKEDITOR.TRISTATE_ON){for(c.removeListener("resize",t),T=[T,u],E=0;E<T.length;E++)s(T[E],T[E].getCustomData("maximize_saved_styles")),T[E].removeCustomData("maximize_saved_styles");for(E=e.container;E=E.getParent();)s(E,E.getCustomData("maximize_saved_styles")),E.removeCustomData("maximize_saved_styles");CKEDITOR.env.ie?setTimeout(function(){c.$.scrollTo(l.x,l.y)},0):c.$.scrollTo(l.x,l.y),u.removeClass("cke_maximized"),CKEDITOR.env.webkit&&(u.setStyle("display","inline"),setTimeout(function(){u.setStyle("display","block")},0)),e.fire("resize")}this.toggleState(),(E=this.uiItems[0])&&(T=this.state==CKEDITOR.TRISTATE_OFF?m.maximize.maximize:m.maximize.minimize,E=CKEDITOR.document.getById(E._.id),E.getChild(1).setHtml(T),E.setAttribute("title",T),E.setAttribute("href",'javascript:void("'+T+'");')),"wysiwyg"==e.mode?o?(CKEDITOR.env.gecko&&n(e),e.getSelection().selectRanges(o),(g=e.getSelection().getStartElement())&&g.scrollIntoView(!0)):c.$.scrollTo(a.x,a.y):(o&&(g.selectionStart=o[0],g.selectionEnd=o[1]),g.scrollLeft=a[0],g.scrollTop=a[1]),o=a=null,d=this.state,e.fire("maximize",this.state)},canUndo:!1}),e.ui.addButton&&e.ui.addButton("Maximize",{label:m.maximize.maximize,command:"maximize",toolbar:"tools,10"}),e.on("mode",function(){var t=e.getCommand("maximize");t.setState(t.state==CKEDITOR.TRISTATE_DISABLED?CKEDITOR.TRISTATE_DISABLED:d)},null,null,100)}}})}();