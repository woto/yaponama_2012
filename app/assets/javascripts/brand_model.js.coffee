format = (data) -> 
  #if (!state.id) return state.text; // optgroup
  #"<img class='flag' src='" + data.thumb + "'/>" + data.text;
  if data.new?
    "Создать: " + data.text.toString().toUpperCase()
  else
    data.text

format_z = (data) ->
  data.text.toString().toUpperCase()

$ ->
  initSelect2()

$(document).on 'page:load', ->
  initSelect2()

$(document).on 'cocoon:after-insert', '#cars', ->
  initSelect2()

initSelect2 = ->
  console

  $("#cars > .nested-fields").each (idx, scope) -> 

    brand = undefined
    $(scope).find("input[id$='brand']").each (idx, el) ->
      brand = el

    model = undefined
    $(scope).find("input[id$='model']").each (idx, el) ->
      model = el

    generation = undefined
    $(scope).find("input[id$='generation']").each (idx, el) ->
      generation = el


    modification = undefined
    $(scope).find("input[id$='modification']").each (idx, el) ->
      modification = el



    # BRAND
    $(brand).select2
      placeholder: ''
      allowClear: true
      initSelection: (element, callback) ->
        callback
        data =
          id: $(element).val()
          text: $(element).val()
        callback data
      formatResult: format
      formatSelection: format_z
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

        $.getJSON "/admin/brands/search/?" + $.param(params), (data) ->

          data.map (data) ->
            zzz.results.push
              id: data.name
              text: data.name


          if data.length
            zzz.more = true

          options.callback zzz


    # MODEL
    $(model).select2
      placeholder: ''
      allowClear: true
      initSelection: (element, callback) ->
        callback
        data =
          id: $(element).val()
          text: $(element).val()
        callback data
      formatResult: format
      formatSelection: format_z
      query: (options) ->

        params =
          page: options.page
          name: options.term
          brand: $(brand).select2('val')

        zzz = undefined
        zzz = results: []

        unless options.context?
          if options.page <= 1
            if options.term? && options.term.length > 0
              zzz.results.push
                id: options.term
                text: options.term
                new: true

        $.getJSON "/admin/models/search/?" + $.param(params), (data) ->

          data.map (data) ->
            zzz.results.push
              id: data.name
              text: data.name

          if data.length
            zzz.more = true

          options.callback zzz

    # GENERATION
    $(generation).select2
      placeholder: ''
      allowClear: true
      initSelection: (element, callback) ->
        callback
        data =
          id: $(element).val()
          text: $(element).val()
        callback data
      formatResult: format
      formatSelection: format_z
      query: (options) ->

        params =
          page: options.page
          name: options.term
          model: $(model).select2('val')

        zzz = undefined
        zzz = results: []

        unless options.context?
          if options.page <= 1
            if options.term? && options.term.length > 0
              zzz.results.push
                id: options.term
                text: options.term
                new: true

        $.getJSON "/admin/generations/search/?" + $.param(params), (data) ->

          data.map (data) ->
            zzz.results.push
              id: data.name
              text: data.name

          if data.length
            zzz.more = true

          options.callback zzz



    # MODIFICATION
    $(modification).select2
      placeholder: ''
      allowClear: true
      initSelection: (element, callback) ->
        callback
        data =
          id: $(element).val()
          text: $(element).val()
        callback data
      formatResult: format
      formatSelection: format_z
      query: (options) ->

        params =
          page: options.page
          name: options.term
          generation: $(generation).select2('val')

        zzz = undefined
        zzz = results: []

        unless options.context?
          if options.page <= 1
            if options.term? && options.term.length > 0
              zzz.results.push
                id: options.term
                text: options.term
                new: true

        $.getJSON "/admin/modifications/search/?" + $.param(params), (data) ->

          data.map (data) ->
            zzz.results.push
              id: data.name
              text: data.name

          if data.length
            zzz.more = true

          options.callback zzz

    # TODO сделать логику в связных списках
    # а так же попытаться переделать в одну сущность с бесконечной
    # вложенностью (если не потребуется вычлененеия отдельных элементов ( модификация, поколение и т.д.))
    #$(aaa).select2('disable')
    #$(aaa).on 'change', ->
    #$(aaa).select2("val")
    #$(aaa).select2("val", "")
