CodeMirror.defineOption("showTrailingSpace",!1,function(r,n,e){e==CodeMirror.Init&&(e=!1),e&&!n?r.removeOverlay("trailingspace"):!e&&n&&r.addOverlay({token:function(r){for(var n=r.string.length,e=n;e&&/\s/.test(r.string.charAt(e-1));--e);return e>r.pos?(r.pos=e,null):(r.pos=n,"trailingspace")},name:"trailingspace"})});