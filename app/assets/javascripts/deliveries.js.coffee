App = exports ? this

# Поиск маршрута
App.calcRoute = (destination) ->
  request =
    origin: $('#warehouse_address').text()
    destination: destination
    travelMode: eval("google.maps.TravelMode." + $('#travel_mode').text())

  #request = 
  #  origin: "Россия, Москва, Красная площадь, 3",
  #  destination: "город Москва улица Верхняя 4", 
  #  travelMode: "DRIVING"

  #console.log request

  directionsService = new google.maps.DirectionsService()

  directionsService.route request, (response, status) ->
    switch status
      when google.maps.DirectionsStatus.OVER_QUERY_LIMIT
        alert 'Превышена частота запросов, пожалуйста, попробуйте еще раз.'
      when google.maps.DirectionsStatus.ZERO_RESULTS, google.maps.DirectionsStatus.NOT_FOUND
        alert 'Указанный адрес не найден, попробуйте уточнить запрос'
      when google.maps.DirectionsStatus.OK
        if response.routes.length != 1
          alert 'routes != 1'
        else
          route = response.routes[0]
          if route.legs.length != 1
            alert 'legs != 1'
          else
            leg = route.legs[0]

            lat = leg.end_location.lat()
            lng = leg.end_location.lng()
            coords = new google.maps.LatLng(lat, lng)

            found = undefined

            $('.delivery_zone').each ->
              poly = $(this).data('polygon')
              if google.maps.geometry.poly.containsLocation(coords, poly)
                if !found? || parseInt(poly.zIndex) > parseInt(found.data('polygon').zIndex)
                  found = $(this)

            if found?
              found.data('polygon').activate(found, undefined)
              if found.find('.realize').text() == 'true'
                $a = found.next().find('.delivery-variant').clone()
                $a.find('form').append($('#assa-inject').html())
                $('#assa-form').append($a)
              else
                $('#assa-form').append('Сожалеем, доставка по Вашему адресу не может быть осуществлена. Не обслуживаемая область.')

            else
              if $('#automatic_calculate_active').text() == 'true'
                window.map.setZoom(16)
                window.map.setCenter(coords)
                marker = new google.maps.Marker
                  map: window.map
                  position: coords
                delivery_cost = Math.round(leg.duration.value/60 * parseFloat($('#delivery_minute_cost').text()))
                if delivery_cost > parseFloat($('#max_automatic_calculated_cost').text())
                  $('#assa-form').append("Сожалеем, доставка по Вашему адресу не может быть осуществлена. Превышено расстояние от центрального склада.")
                else
                  $('#assa-form').append("<p>Стоимость доставки: " + delivery_cost + " руб.</p>")
                  $a = $('#jjj').clone()
                  $a.find('[name="order[delivery_cost]"]').val(delivery_cost)
                  $a.find('form').append($('#assa-inject').html())
                  $('#assa-form').append($a)
              else
                alert('Автоматический расчет стоимости доставки выключен. [TODO]')

      else
        alert status

window.initClientMap = ->

  zoom_and_move_to_common_style = (polygon) ->
    lat = polygon.common_style.lat
    lng = polygon.common_style.lng
    zoom = polygon.common_style.zoom

    window.map.setZoom(zoom)
    window.map.setCenter(new google.maps.LatLng(lat, lng))

  previous_selected = undefined

  activate_polygon_and_marker = (that, func) ->

    previous_selected.inactivate() if previous_selected

    func.apply null



  google.maps.Polygon::activate = (that, event) ->

    infoWindow.close(map)

    aaa = this
    activate_polygon_and_marker that, ->
      previous_selected = aaa
      zoom_and_move_to_common_style aaa
      aaa.setOptions aaa.active_style

    if event?
      content = ($(that).closest('.panel').find('.infomap-content').map ->
        $(this).html()).get().join("<hr />")
      infoWindow.setContent(content)
      infoWindow.setPosition(event.latLng)
      infoWindow.open(map)




  google.maps.Polygon::inactivate = ->
    this.setOptions(this.inactive_style)

  google.maps.Marker::activate = (that, event) ->

    infoWindow.close(map)

    that.closest('.accordion-group').find('.collapse').collapse('show')
    # TODO Раньше (до удаления ui) была подсветка
    #that.parent().effect('highlight')

    aaa = this
    activate_polygon_and_marker that, ->
      previous_selected = aaa.polygon
      zoom_and_move_to_common_style aaa.polygon
      aaa.polygon.setOptions aaa.polygon.active_style

  google.maps.Marker::inactivate = ->
    this.polygon.setOptions(this.polygon.inactive_style)


          #$('#geocode-address-button').on 'click', (event) ->
          #  debugger
          #  event.preventDefault()
          #  calcRoute($('#postal_address_street').val() + " " + $('#postal_address_house').val())

  $('.delivery_zone a').on 'click', ->
    dz = $(this).closest('.delivery_zone')
    dz.data('polygon').activate(dz, undefined)

  infoWindow = new google.maps.InfoWindow(
    maxWidth: 200
  )

  add_event_listener_to_object = (object, that) ->

    google.maps.event.addListener object, 'click', (event) ->

      object.activate(that, event)

  window.map = new google.maps.Map(document.getElementById("clientMap"),
    zoom: parseInt($('#initial_map_zoom').text())
    center: new google.maps.LatLng(parseFloat($('#initial_map_lat').text()), parseFloat($('#initial_map_lng').text()))
    mapTypeId: google.maps.MapTypeId.ROADMAP
    disableDefaultUI: true
    zoomControl: true
    scrollwheel: false
  )

  $('.delivery_zone').each ->

    path = google.maps.geometry.encoding.decodePath($(this).find('.vertices').text())

    poly = new google.maps.Polygon
      zIndex: $(this).find('.z_index').text()

    poly.common_style =
      zoom: parseInt($(this).find('.zoom').text())
      lat: parseFloat(($(this).find('.lat').text()))
      lng: parseFloat(($(this).find('.lng').text()))

    poly.active_style =
      fillColor: $(this).find('.active .fill_color').text()
      fillOpacity: $(this).find('.active .fill_opacity').text()
      strokeColor: $(this).find('.active .stroke_color').text()
      strokeOpacity: $(this).find('.active .stroke_opacity').text()
      strokeWeight: $(this).find('.active .stroke_weight').text()

    poly.inactive_style =
      fillColor: $(this).find('.inactive .fill_color').text()
      fillOpacity: $(this).find('.inactive .fill_opacity').text()
      strokeColor: $(this).find('.inactive .stroke_color').text()
      strokeOpacity: $(this).find('.inactive .stroke_opacity').text()
      strokeWeight: $(this).find('.inactive .stroke_weight').text()

    poly.inactivate()

    poly.setMap(window.map)

    poly.setPath path

    $(this).data('polygon', poly)

    add_event_listener_to_object(poly, $(this))

    # Показываем маркер, если надо
    if $(this).find('.display_marker').text() == 'true'

      bounds = new google.maps.LatLngBounds()

      for step in path
        bounds.extend step

      marker = new google.maps.Marker
          icon: '/marker.png'
          position: bounds.getCenter()
          #title: $(this).find('.accordion-toggle strong').text()

      marker.polygon = poly

      marker.setMap(window.map)

      add_event_listener_to_object(marker, $(this))

$ ->
  if $('#clientMap').length != 0
    $.cachedScript('http://maps.google.com/maps/api/js?sensor=false&libraries=geometry&callback=initClientMap')

$(document).on 'shown.bs.collapse', '[data-parent="#deliveries-accordion"]', (event) ->
  $("html, body").animate({scrollTop: $(event.target).closest('.accordion-group').offset().top - 5}, 'fast')
