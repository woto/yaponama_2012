$(function () {
    $('.tree li li').hide();
    //$('.tree li:first').show();
    $('.tree li').on('click', function (e) {
      if($(this).hasClass('collapsible'))
      {
        e.preventDefault();
        var children = $(this).find('> ul > li');
        if (children.is(":visible")) {
          $(this).find('> a .fa').remove()
          $(this).find('> a').prepend('<i class="fa fa-plus"></i>');
          children.hide('fast');
        } else {
          $(this).find('> a .fa').remove()
          $(this).find('> a').prepend('<i class="fa fa-minus"></i>');
          children.show('fast');
        }
      }
      e.stopPropagation();
    });
});

