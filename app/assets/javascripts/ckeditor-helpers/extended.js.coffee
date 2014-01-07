App = exports ? this

$(document).on 'update-ckeditor-extended', ->
  App.initExtendedCkeditor();

$(document).on 'page:load', (e) ->
  $(document).trigger('update-ckeditor-extended')

$ ->
  $(document).trigger('update-ckeditor-extended')

window.initExtendedCkeditor = ->
  placeholders = $('.ckeditor-extended')
  if placeholders.length > 0
    $(placeholders).removeClass('ckeditor-extended').addClass('ckeditor-extended-initialized')
    url = "/assets/ckeditor/ckeditor.js"
    $.cachedScript(url).done (script, textStatus) ->
      CKEDITOR.plugins.addExternal('upload', '/assets/upload/', 'plugin.js');
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
