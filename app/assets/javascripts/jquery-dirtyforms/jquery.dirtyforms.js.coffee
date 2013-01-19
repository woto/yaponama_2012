root = exports ? this # http://stackoverflow.com/questions/4214731/coffeescript-global-variables

$(document).on 'page:load', (e) ->
  new root.DirtyForms.get

$ ->
  new root.DirtyForms.get

# The publicly accessible Singleton fetcher
class root.DirtyForms
  _instance = undefined # Must be declared here to force the closure on the class
  @get: (args) -> # Must be a static method
    _instance ?= new _DirtyForms args

# The actual Singleton class
class _DirtyForms
  constructor: ->
    # Selector for forms which need to check on dirty
    @forms_selector = 'form.dirtyforms'

    # Customize you alert message
    @confirmation_message = 'Данные не сохренны. Если вы продолжите, то не сохраненные данные будут утеряны, продолжить?'

    # Which css classes to ignore
    @ignore_dirty = '.ignoredirty, .cke'
    # where .btn-primary .cke_dialog_body, .cke_content TODO check if they are don't needed

    # How to highligh dirty elements .control-group uses in twitter bootstrap
    @highlight_dirty = (el) -> 
      $(el).closest('.control-group').addClass('dirty')

    # We need this tweak for correct working with turbolinks
    @custom_reset_dirty = ->
      if CKEDITOR?
        for own key of CKEDITOR.instances
          ckeditor = CKEDITOR.instances[key]
          ckeditor.resetDirty()


    # Modify it's method for you needs. TinyMCE may be...
    @custom_check_dirty = ->
      if CKEDITOR?
        for own key of CKEDITOR.instances
          ckeditor = CKEDITOR.instances[key]
          if ckeditor.checkDirty()
            return true

    @dirty = false

    $(window).on 'beforeunload', @beforeunload
    $(document).on 'click', 'a', @click
    $(document).on 'change', @forms_selector, @change
    $(document).on 'submit', @forms_selector, @submit
    $(document).on 'ajax:beforeSend', @rails

    if CKEDITOR?
      add_instance_ready_handler CKEDITOR

  lazy_added_ckeditor: (ckeditor) =>
    @add_instance_ready_handler ckeditor
    

  add_instance_ready_handler: (ckeditor) =>
    # Because CKEditor doesn't have change event
    ckeditor.on 'instanceReady', (e) =>
      e.editor.on 'blur', => 
        if e.editor.checkDirty()
          @highlight_dirty(e.editor.element.$)



  rails: (e) =>
    unless ( $(e.target).is(@forms_selector) )
      if @check_all_dirty()
        retval = confirm(@confirmation_message)
        unless retval
          $.rails.stopEverything(e)
        else
          @reset_all_dirty()

  submit: =>
    if @check_all_dirty()
      @reset_all_dirty()
      $(window).off 'beforeunload', @beforeunload

  click: (e) =>
    op1 = $(e.target).closest(@ignore_dirty)
    op1 = op1.length > 0
    op2 = e.isDefaultPrevented()
    if (!op1 && !op2)
      if @check_all_dirty()
        retval = confirm(@confirmation_message)
        if retval
          @reset_all_dirty()
        retval

  beforeunload: =>
    if @check_all_dirty()
      @confirmation_message

  change: (e) =>
    @dirty = true
    @highlight_dirty(e.target)

  check_all_dirty: =>
    @dirty || @custom_check_dirty()

  reset_all_dirty: =>
    @dirty = false
    @custom_reset_dirty()
