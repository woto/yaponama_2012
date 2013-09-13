$("body").on "click.collapse-next.data-api", "[data-toggle=collapse-next]", (e) ->
  $target = $(this).parent().next()
  (if $target.data("collapse") then $target.collapse("toggle") else $target.collapse())
