CKEDITOR.plugins.add("format",{requires:"richcombo",lang:"af,ar,bg,bn,bs,ca,cs,cy,da,de,el,en,en-au,en-ca,en-gb,eo,es,et,eu,fa,fi,fo,fr,fr-ca,gl,gu,he,hi,hr,hu,id,is,it,ja,ka,km,ko,ku,lt,lv,mk,mn,ms,nb,nl,no,pl,pt,pt-br,ro,ru,si,sk,sl,sq,sr,sr-latn,sv,th,tr,ug,uk,vi,zh,zh-cn",init:function(e){if(!e.blockless){for(var t=e.config,n=e.lang.format,a=t.format_tags.split(";"),i={},o=0,r=[],l=0;l<a.length;l++){var s=a[l],f=new CKEDITOR.style(t["format_"+s]);(!e.filter.customConfig||e.filter.check(f))&&(o++,i[s]=f,i[s]._.enterMode=e.config.enterMode,r.push(f))}0!==o&&e.ui.addRichCombo("Format",{label:n.label,title:n.panelTitle,toolbar:"styles,20",allowedContent:r,panel:{css:[CKEDITOR.skin.getPath("editor")].concat(t.contentsCss),multiSelect:!1,attributes:{"aria-label":n.panelTitle}},init:function(){this.startGroup(n.panelTitle);for(var e in i){var t=n["tag_"+e];this.add(e,i[e].buildPreview(t),t)}},onClick:function(t){e.focus(),e.fire("saveSnapshot");var t=i[t],n=e.elementPath();e[t.checkActive(n)?"removeStyle":"applyStyle"](t),setTimeout(function(){e.fire("saveSnapshot")},0)},onRender:function(){e.on("selectionChange",function(t){var n=this.getValue(),t=t.data.path,a=!e.readOnly&&t.isContextFor("p");if(this[a?"enable":"disable"](),a){for(var o in i)if(i[o].checkActive(t))return void(o!=n&&this.setValue(o,e.lang.format["tag_"+o]));this.setValue("")}},this)}})}}}),CKEDITOR.config.format_tags="p;h1;h2;h3;h4;h5;h6;pre;address;div",CKEDITOR.config.format_p={element:"p"},CKEDITOR.config.format_div={element:"div"},CKEDITOR.config.format_pre={element:"pre"},CKEDITOR.config.format_address={element:"address"},CKEDITOR.config.format_h1={element:"h1"},CKEDITOR.config.format_h2={element:"h2"},CKEDITOR.config.format_h3={element:"h3"},CKEDITOR.config.format_h4={element:"h4"},CKEDITOR.config.format_h5={element:"h5"},CKEDITOR.config.format_h6={element:"h6"};