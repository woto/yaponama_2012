$(document).on('page:fetch',   function() { NProgress.start(); });
$(document).on('page:update',  function() { NProgress.done(); });
$(document).on('page:restore', function() { NProgress.remove(); });

$(document).on('submit', 'form[data-remote=true]', function() { NProgress.start(); });
$(document).on('click', 'a[data-remote=true]', function() { NProgress.start(); });
