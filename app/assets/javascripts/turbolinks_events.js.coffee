$(document).on 'page:fetch', -> 
  console.log '[page:fetch] Starting to fetch the target page (only called if loading fresh, not from cache).'
$(document).on 'page:load', -> 
  console.log '[page:load] Fetched page is being retrieved fresh from the server.'
$(document).on 'page:restore', -> 
  console.log '[page:restore] Fetched page is being retrieved from the 10-slot client-side cache.'
$(document).on 'page:change', -> 
  console.log '[page:change] Page has changed to the newly fetched version.'
$(document).on 'page:receive', -> 
  console.log '[page:receive] Page has been fetched from the server, but not yet parsed.'
