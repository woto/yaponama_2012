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
  $("[rel='select2-spare_catalog']").select2
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
        q:
          name_matches: options.term

      zzz = undefined
      zzz = results: []

      unless options.context?
        if options.page <= 1
          if options.term? && options.term.length > 0
            zzz.results.push
              id: options.term
              text: options.term
              new: true

      $.getJSON "/admin/spare_catalogs/?" + $.param(params), (data) ->

        data.map (data) ->
          zzz.results.push
            id: data.name
            true_id: data.id
            text: data.name
            #thumb: data.image.thumb.url


        if data.length
          zzz.more = true

        options.callback zzz
