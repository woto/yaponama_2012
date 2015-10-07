Пока что оставлю.
TODO

$(function(){
  if($('.made-to-order').length > 0){
    uri = URI();
    catalog_number = uri.query(true).catalog_number;
    $('.made-to-order').each(function(index, element){
      if(price_host = $(element).attr('price_host')) {
        $.getJSON('http://'+price_host+"/prices/search?catalog_number="+catalog_number+"&format=json")
          .done(function(data){
            console.log(data);
          });
        //http://partners.avtorif.ru/prices/search?catalog_number=3310&for_site=1&format=json
      }
    }) 
  }
})
