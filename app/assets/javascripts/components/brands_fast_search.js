(function() {
  throttled = _.throttle(function(form) {
    $(form).trigger('submit.rails');
  }, 300);

  $(document).on('input', '[brands-fast-search]', function() {
    return throttled($(this).closest('form'));
  });
})();
