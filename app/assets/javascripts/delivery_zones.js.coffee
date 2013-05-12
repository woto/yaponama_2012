# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

window.initMap = ->


  window.codeAddress = ->

    address = $('#warehouse-address').data('value')

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
        alert "Geocode was not successful for the following reason: " + status

  clearSelection = ->
    if selectedShape
      selectedShape.setEditable false
      selectedShape = null
  setSelection = (shape) ->
    clearSelection()
    selectedShape = shape
    shape.setEditable true
    
  update_vertices = (shape) ->
    $('#delivery_zone_vertices').val(JSON.stringify(shape.getPath().getArray()));

  add_events_handler_to_shape = (shape) ->
    google.maps.event.addListener shape.getPath(), 'set_at', (index) ->
      update_vertices(shape)
    google.maps.event.addListener shape.getPath(), 'remove_at', (index) ->
      update_vertices(shape)
    google.maps.event.addListener shape.getPath(), 'insert_at', (index) ->
      update_vertices(shape)

    google.maps.event.addListener shape, "rightclick", (mev) ->
      shape.getPath().removeAt mev.vertex  if mev.vertex?




  initialize = ->
    window.map = new google.maps.Map(document.getElementById("map"),
      zoom: 15
      center: new google.maps.LatLng(55.75, 37.60)
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



    google.maps.event.addListener window.drawingManager, "overlaycomplete", (e) ->

      dont_allow_further_adding()

      
      # Add an event listener that selects the newly-drawn shape when the user
      # mouses down on it.
      newShape = e.overlay
      newShape.type = e.type

      setSelection newShape

      update_vertices(newShape)

      add_events_handler_to_shape(newShape)


    if $('#delivery_zone_vertices').val() != ''
      poly = new google.maps.Polygon(polyOptions)
      poly.setMap(map)

      path = new google.maps.MVCArray;

      $.each JSON.parse($('#delivery_zone_vertices').val()), (key, val) ->
        path.push(new google.maps.LatLng(val.kb, val.lb));

      poly.setPath path
      setSelection poly
      add_events_handler_to_shape(poly)
      dont_allow_further_adding()


    window.geocoder = new google.maps.Geocoder();
    window.codeAddress()
    
    # Clear the current selection when the drawing mode is changed, or when the
    # map is clicked.
    google.maps.event.addListener window.drawingManager, "drawingmode_changed", clearSelection
    google.maps.event.addListener window.map, "click", clearSelection



  window.drawingManager = undefined
  selectedShape = undefined
  initialize();


$ ->
  if $('#map').length != 0
    $.cachedScript('http://maps.google.com/maps/api/js?sensor=false&libraries=drawing&callback=initMap')

$(document).on 'page:change', ->
  if $('#map').length != 0
    $.cachedScript('http://maps.google.com/maps/api/js?sensor=false&libraries=drawing&callback=initMap')
