window.Application ||= {}

format_result = (data) -> 
  if data.new?
    "Создать: " + data.text.toString().toUpperCase()
  else
    data.text
    #if (!data.id) 
    #  data.text
    #else
    #  "<img src='" + data.thumb + "'/>" + data.text

format_selection = (data) ->
  data.text.toString().toUpperCase()

$ ->
  Application.initSelect2()

$(document).on 'page:load', ->
  Application.initSelect2()

# TODO позже разобраться, когда начну делать подгрузку фильтров через ajax
# Делается вызов где-то из js.erb (в продуктах чтоли)
Application.initSelect2 = ->

  # Так уже не надо
  brand = undefined
  $("input[rel='select2-brand']").each (idx, el) ->
    brand = el

  model = undefined
  $("input[rel='select2-model']").each (idx, el) ->
    model = el

  generation = undefined
  $("input[rel='select2-generation']").each (idx, el) ->
    generation = el

  modification = undefined
  $("input[rel='select2-modification']").each (idx, el) ->
    modification = el



  #####################################
  #####################################
  # BRAND
  #####################################
  #####################################
  $(brand).select2
    #placeholder: ''
    allowClear: true
    initSelection: (element, callback) ->
      data =
        id: $(element).val()
        true_id: $(element).data('true-id')
        text: $(element).val()
      callback data
    formatResult: format_result
    formatSelection: format_selection
    #minimumInputLength: 1
    query: (options) ->

      params = 
        page: options.page
        name: options.term

      zzz = undefined
      zzz = results: []

      unless options.context?
        if options.page <= 1
          if options.term? && options.term.length > 0
            zzz.results.push
              id: options.term
              text: options.term
              new: true

      $.getJSON "/brands/search/?" + $.param(params), (data) ->

        data.map (data) ->
          zzz.results.push
            id: data.name
            true_id: data.id
            text: data.name
            #thumb: data.image.thumb.url


        if data.length
          zzz.more = true

        options.callback zzz

  $(brand).on 'change', ->
    $(model).select2("val", "")
    $(generation).select2("val", "")
    $(modification).select2("val", "")


  #####################################
  #####################################
  # MODEL
  #####################################
  #####################################
  $(model).select2
    #placeholder: ''
    allowClear: true
    initSelection: (element, callback) ->
      data =
        id: $(element).val()
        true_id: $(element).data('true-id')
        text: $(element).val()
      callback data
    formatResult: format_result
    formatSelection: format_selection
    query: (options) ->

      params =
        page: options.page
        name: options.term
        brand_id: -1

      if $(brand).length > 0 && $(brand).select2('data')? && $(brand).select2('data').true_id?
        params['brand_id'] = $(brand).select2('data').true_id

      zzz = undefined
      zzz = results: []

      unless options.context?
        if options.page <= 1
          if options.term? && options.term.length > 0
            zzz.results.push
              id: options.term
              text: options.term
              new: true

      $.getJSON "/models/search/?" + $.param(params), (data) ->

        data.map (data) ->
          zzz.results.push
            id: data.name
            true_id: data.id
            text: data.name

        if data.length
          zzz.more = true

        options.callback zzz

  $(model).on 'change', ->
    $(generation).select2("val", "")
    $(modification).select2("val", "")


  #####################################
  #####################################
  # GENERATION
  #####################################
  #####################################
  $(generation).select2
    #placeholder: ''
    allowClear: true
    initSelection: (element, callback) ->
      data =
        id: $(element).val()
        true_id: $(element).data('true-id')
        text: $(element).val()
      callback data
    formatResult: format_result
    formatSelection: format_selection
    query: (options) ->

      params =
        page: options.page
        name: options.term
        model_id: -1

      if $(model).length > 0 && $(model).select2('data') && $(model).select2('data').true_id?
        params['model_id'] = $(model).select2('data').true_id

      zzz = undefined
      zzz = results: []

      unless options.context?
        if options.page <= 1
          if options.term? && options.term.length > 0
            zzz.results.push
              id: options.term
              text: options.term
              new: true

      $.getJSON "/generations/search/?" + $.param(params), (data) ->

        data.map (data) ->
          zzz.results.push
            id: data.name
            true_id: data.id
            text: data.name

        if data.length
          zzz.more = true

        options.callback zzz

  $(generation).on 'change', ->
    $(modification).select2("val", "")



  #####################################
  #####################################
  # MODIFICATION
  #####################################
  #####################################
  $(modification).select2
    #placeholder: ''
    allowClear: true
    initSelection: (element, callback) ->
      data =
        id: $(element).val()
        true_id: $(element).data('true-id')
        text: $(element).val()
      callback data
    formatResult: format_result
    formatSelection: format_selection
    query: (options) ->

      params =
        page: options.page
        name: options.term
        generation_id: -1

      if $(generation).length > 0 && $(generation).select2('data')? && $(generation).select2('data').true_id?
        params['generation_id'] = $(generation).select2('data').true_id

      zzz = undefined
      zzz = results: []

      unless options.context?
        if options.page <= 1
          if options.term? && options.term.length > 0
            zzz.results.push
              id: options.term
              text: options.term
              new: true

      $.getJSON "/modifications/search/?" + $.param(params), (data) ->

        data.map (data) ->
          zzz.results.push
            id: data.name
            true_id: data.id
            text: data.name

        if data.length
          zzz.more = true

        options.callback zzz
