root = exports ? window # http://stackoverflow.com/questions/4214731/coffeescript-global-variables

$(document).on 'page:load', (e) ->
  window.initExtendedCkeditor()

$ ->
  window.initExtendedCkeditor()

window.initExtendedCkeditor = ->
  placeholders = $('.ckeditor-extended')
  if placeholders.length > 0
    url = "/assets/ckeditor/ckeditor.js"
    $.cachedScript(url).done (script, textStatus) ->
      CKEDITOR.plugins.addExternal('oembed', '/assets/oembed/', 'plugin.js');
      CKEDITOR.plugins.addExternal('codemirror', '/assets/codemirror/', 'plugin.js');
      CKEDITOR.plugins.addExternal('timestamp', '/assets/timestamp/', 'plugin.js');
      CKEDITOR.plugins.addExternal('abbr', '/assets/abbr/', 'plugin.js');
      for ckeditor, i in placeholders
        tmp_ckeditor = CKEDITOR.replace(ckeditor, window.extended_options)
        root = exports ? window # http://stackoverflow.com/questions/4214731/coffeescript-global-variables
        if root? && root.DirtyForms?
          dirtyforms = new root.DirtyForms.get
          dirtyforms.lazy_added_ckeditor(tmp_ckeditor)




