$ ->
  $(document).on 'click', '.collapse-buttons', ->
    $(this).parent().next('.collapse-fields').collapse('toggle')

