$ ->
  selector = 'ul.dropdown-menu [data-toggle=dropdown]'

  $(selector).on 'click', (event) ->

  #$(document).on 'click', 'ul.dropdown-menu [data-toggle=dropdown]', (event) ->

    # Avoid following the href location when clicking
    event.preventDefault()

    # Avoid having the menu to close when clicking
    event.stopPropagation()

    # If a menu is already open we close it

    for el in _.difference($(selector).parent().toArray(), $(this).parents().toArray())
      $(el).removeClass('open')

    # opening the one you clicked on
    $(this).parent().addClass "open"
    menu = $(this).parent().find("ul")
    menupos = menu.offset()

    if (menupos.left + menu.width()) + 30 > $(window).width()
      newpos = -menu.width()
    else
      newpos = $(this).parent().width()

    menu.css left: newpos

    return false
