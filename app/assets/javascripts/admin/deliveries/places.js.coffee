window.initMap = ->

  $(document).on 'click', '#geocode-address-button', ->
    window.geocoder = new google.maps.Geocoder()
    window.codeAddress($('#geocode-address-text').val())

  window.codeAddress = (address) ->

    window.geocoder.geocode
      address: address
    , (results, status) ->
      if status is google.maps.GeocoderStatus.OK
        window.map.setCenter results[0].geometry.location
        marker = new google.maps.Marker(
          map: window.map
          position: results[0].geometry.location
        )
      else
        console.log "Не удалось определить местоположение, попробуйте уточнить запрос. " + status

  clearSelection = ->
    if selectedShape
      selectedShape.setEditable false
      selectedShape = null
  setSelection = (shape) ->
    clearSelection()
    selectedShape = shape
    shape.setEditable true
    
  update_vertices = (shape) ->
    $('#deliveries_place_vertices').val(google.maps.geometry.encoding.encodePath(shape.getPath()))

  add_events_handler_to_shape = (shape) ->

    allow_furher_adding = ->
      window.drawingManager.setDrawingMode google.maps.drawing.OverlayType.POLYGON

      drawingManager.setOptions
        drawingControl: true

    google.maps.event.addListener shape.getPath(), 'set_at', (index) ->
      update_vertices(shape)
    google.maps.event.addListener shape.getPath(), 'remove_at', (index) ->
      update_vertices(shape)
    google.maps.event.addListener shape.getPath(), 'insert_at', (index) ->
      update_vertices(shape)

    google.maps.event.addListener shape, "rightclick", (mev) ->
      path = shape.getPath()
      if path.getLength() <= 3
        path.clear()
        allow_furher_adding()
      else
        shape.getPath().removeAt mev.vertex  if mev.vertex?

  initialize = ->
    window.map = new google.maps.Map(document.getElementById("map"),
      zoom: parseInt($('#initial_map_zoom').text())
      center: new google.maps.LatLng(parseFloat($('#initial_map_lat').text()), parseFloat($('#initial_map_lng').text()))
      mapTypeId: google.maps.MapTypeId.ROADMAP
      disableDefaultUI: true
      zoomControl: true
    )

    polyOptions =
      strokeWeight: 0
      fillOpacity: 0.45
      editable: true
    
    # Creates a drawing manager attached to the map that allows the user to draw
    # markers, lines, and shapes.
    window.drawingManager = new google.maps.drawing.DrawingManager(
      drawingMode: google.maps.drawing.OverlayType.POLYGON
      drawingControlOptions:
        drawingModes: [
          google.maps.drawing.OverlayType.POLYGON
        ]
      polygonOptions: polyOptions
      map: window.map
    )

    dont_allow_further_adding = ->
      # Switch back to non-drawing mode after drawing a shape.
      window.drawingManager.setDrawingMode null

      drawingManager.setOptions
        drawingControl: false

    zoom_and_center = ->
      window.map.setZoom(parseInt($('#initial_map_zoom').text()))
      lat = parseFloat($('#initial_map_lat').text())
      lng = parseFloat($('#initial_map_lng').text())
      coords = new google.maps.LatLng(lat, lng)
      window.map.setCenter(coords)


    google.maps.event.addListener window.drawingManager, "overlaycomplete", (e) ->

      dont_allow_further_adding()

      
      # Add an event listener that selects the newly-drawn shape when the user
      # mouses down on it.
      newShape = e.overlay
      newShape.type = e.type

      setSelection newShape

      update_vertices(newShape)

      add_events_handler_to_shape(newShape)


    # Инициализация карты
    if $('#deliveries_place_vertices').val() != ''
      poly = new google.maps.Polygon(polyOptions)
      poly.setMap(map)

      path = google.maps.geometry.encoding.decodePath($('#deliveries_place_vertices').val())

      poly.setPath path
      setSelection poly
      add_events_handler_to_shape(poly)
      dont_allow_further_adding()
      zoom_and_center()

    
    # Clear the current selection when the drawing mode is changed, or when the
    # map is clicked.
    google.maps.event.addListener window.drawingManager, "drawingmode_changed", clearSelection
    google.maps.event.addListener window.map, "click", clearSelection



  window.drawingManager = undefined
  selectedShape = undefined
  initialize()


$ ->
  if $('#map').length != 0
    $.cachedScript('http://maps.google.com/maps/api/js?sensor=false&libraries=drawing,geometry&callback=initMap')
