(function(){

  $(document).on('click', "[faq-translocation]", function(event){
    var url = new URI($(event.currentTarget).attr('href'));
    window.location = url;
    update(url);
  })

  $(document).on('ready', function(){
    var url = new URI();
    _.delay(_.bind(update, null, url), 1000);
  })

  update = function(url){
    if(url.filename() == 'faqs'){
      var id = url.fragment();
      var element = $('#faq-collapse-' + id);
      $('.faq-collapse').not(element).collapse('hide');
      element.collapse('show');
      var scroll = function(){
        var top = element.offset().top
        $("html, body").animate({ scrollTop: top - 50 })
      };
      _.delay(scroll, 500);
    }
  }

})();
