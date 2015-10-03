(function(){

  addressString = function(){
    return 'г. Москва, ' + $('#street').val() + " " + $('#house').val()
  }

  calcRoute = function(destination) {
    debugger;
    var request = {
      origin: $('#warehouse_address').text(),
      destination: destination,
      travelMode: eval("google.maps.TravelMode." + $('#travel_mode').text())
    };
    var dirServ = new google.maps.DirectionsService();
    return dirServ.route(request, function(response, status) {
      switch (status) {
        case google.maps.DirectionsStatus.OVER_QUERY_LIMIT:
          $('#deliveries-calculate-result').html('Превышена частота запросов, пожалуйста, попробуйте еще раз.');
          break;
        case google.maps.DirectionsStatus.ZERO_RESULTS:
          $('#deliveries-calculate-result').html('Указанный адрес ' + addressString() +' не найден, попробуйте уточнить запрос.');
          break;
        case google.maps.DirectionsStatus.NOT_FOUND:
          $('#deliveries-calculate-result').html('Указанный адрес ' + addressString() +' не найден, попробуйте уточнить запрос.');
          break;
        case google.maps.DirectionsStatus.OK:
          var route = response.routes[0];
          var leg = route.legs[0];
          var lat = leg.end_location.lat();
          var lng = leg.end_location.lng();
          var coords = new google.maps.LatLng(lat, lng);
          var found;

          $('.delivery_zone').each(function() {
            var poly;
            poly = $(this).data('polygon');
            if (google.maps.geometry.poly.containsLocation(coords, poly)) {
              if ((found == null) || parseInt(poly.zIndex) > parseInt(found.data('polygon').zIndex)) {
                found = $(this);
              }
            }
          });

          if (found != null) {
            if (found.find('.realize').text() === 'true') {
              var $a = found.next().find('.delivery-variant').clone();
              $('#deliveries-calculate-result').html($a)
            } else {
              $('#deliveries-calculate-result').html('Сожалеем, доставка по адресу ' + addressString() + ' не может быть осуществлена. Не обслуживаемая область.');
            }
          } else {
            var delivery_cost = Math.round(leg.duration.value / 60 * parseFloat($('#delivery_minute_cost').text()));
            if (delivery_cost > parseFloat($('#max_automatic_calculated_cost').text())) {
              $('#deliveries-calculate-result').html("Сожалеем, доставка по адресу " + addressString() + " не может быть осуществлена. Превышено расстояние от центрального склада.");
            } else {
              $('#deliveries-calculate-result').html("Стоимость доставки по адресу " + addressString() + " составляет " + delivery_cost + " руб.");
            }
          }

          window.map.setZoom(16);
          window.map.setCenter(coords);
          break;
      }
    });
  };

  window.initClientMap = function() {

    $('#geocode-address-button').on('click', function(event) {
      event.preventDefault();
      inputs = $('#street, #house')
      inputs.each(function(input){
        if(!$(this).val()) {
          $(this).closest('.form-group').addClass('has-error');
        } else {
          $(this).closest('.form-group').removeClass('has-error');
        }
      });
      if(_.all(inputs, function(input) { return $(input).val(); })) {
        calcRoute(addressString());
      } else {
        $('#deliveries-calculate-result').html('Адрес доставки указан неверно.');
      }
    });

    window.map = new google.maps.Map(document.getElementById("clientMap"), {
      zoom: parseInt($('#initial_map_zoom').text()),
      center: new google.maps.LatLng(parseFloat($('#initial_map_lat').text()), parseFloat($('#initial_map_lng').text())),
      mapTypeId: google.maps.MapTypeId.ROADMAP,
      disableDefaultUI: true,
      zoomControl: true,
      scrollwheel: false
    });

    $('.delivery_zone').each(function() {
      var path = google.maps.geometry.encoding.decodePath($(this).find('.vertices').text());
      var poly = new google.maps.Polygon({
        zIndex: $(this).find('.z_index').text(),
        fillOpacity: 0,
        strokeOpacity: 0,
        clickable: false
      });
      poly.setMap(window.map);
      poly.setPath(path);
      $(this).data('polygon', poly);
    });
  };

  $(function() {
    if ($('#clientMap').length !== 0) {
      $.cachedScript('http://maps.google.com/maps/api/js?sensor=false&libraries=geometry&callback=initClientMap');
    }
  });
})();
