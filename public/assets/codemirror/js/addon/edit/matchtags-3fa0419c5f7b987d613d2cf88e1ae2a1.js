!function(){"use strict";function t(t){t.state.tagHit&&t.state.tagHit.clear(),t.state.tagOther&&t.state.tagOther.clear(),t.state.tagHit=t.state.tagOther=null}function a(a){a.state.failedTagMatch=!1,a.operation(function(){if(t(a),!a.somethingSelected()){var e=a.getCursor(),o=a.getViewport();o.from=Math.min(o.from,e.line),o.to=Math.max(e.line+1,o.to);var r=CodeMirror.findMatchingTag(a,e,o);if(r){if(a.state.matchBothTags){var i="open"==r.at?r.open:r.close;i&&(a.state.tagHit=a.markText(i.from,i.to,{className:"CodeMirror-matchingtag"}))}var n="close"==r.at?r.open:r.close;n?a.state.tagOther=a.markText(n.from,n.to,{className:"CodeMirror-matchingtag"}):a.state.failedTagMatch=!0}}})}function e(t){t.state.failedTagMatch&&a(t)}CodeMirror.defineOption("matchTags",!1,function(o,r,i){i&&i!=CodeMirror.Init&&(o.off("cursorActivity",a),o.off("viewportChange",e),t(o)),r&&(o.state.matchBothTags="object"==typeof r&&r.bothTags,o.on("cursorActivity",a),o.on("viewportChange",e),a(o))}),CodeMirror.commands.toMatchingTag=function(t){var a=CodeMirror.findMatchingTag(t,t.getCursor());if(a){var e="close"==a.at?a.open:a.close;e&&t.setSelection(e.to,e.from)}}}();