App = exports ? this

$(document).on 'update-ckeditor-simple', ->
  App.initSimpleCkeditor();

$(document).on 'page:load', (e) ->
  $(document).trigger('update-ckeditor-simple')

$ ->
  $(document).trigger('update-ckeditor-simple')

App.initSimpleCkeditor = ->
  placeholders = $('.ckeditor-simple')
  if placeholders.length > 0
    $(placeholders).removeClass('ckeditor-simple').addClass('ckeditor-simple-initialized')
    url = "/assets/ckeditor/ckeditor.js"
    $.cachedScript(url).done (script, textStatus) ->

      CKEDITOR.plugins.addExternal('upload', '/assets/upload/', 'plugin.js');
      for ckeditor, i in placeholders
        tmp_ckeditor = CKEDITOR.replace(ckeditor, window.simple_options())

        ##################### TODO TODO Не надежный участок
        # Need to wait for the ckeditor instance to finish initialization
        # because CKEDITOR.instances.editor.commands is an empty object
        # if you try to use it immediately after CKEDITOR.replace('editor');
        tmp_ckeditor.on "instanceReady", (ev) ->
          
          # Create a new command with the desired exec function
          overridecmd = new CKEDITOR.command(ev.editor,
            exec: (editor) ->
              
              # Replace this with your desired save button code
              $(editor.element.$.form).find('[type=submit]').trigger('click')
              #$(editor.element.$.form).trigger("submit.rails")
              #alert 'Отправку дописать'
          )
          
          # Replace the old save's exec function with the new one
          ev.editor.commands.save.exec = overridecmd.exec
        ##################### TODO TODO

            

        root = exports ? window # http://stackoverflow.com/questions/4214731/coffeescript-global-variables
        if root? && root.DirtyForms?
          dirtyforms = new root.DirtyForms.get
          dirtyforms.lazy_added_ckeditor(tmp_ckeditor)


