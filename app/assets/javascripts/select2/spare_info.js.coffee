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
  $("[rel='select2-spare_info'],[rel='select2-from_spare_info'],[rel='select2-to_spare_info']").select2
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
          catalog_number_cont: options.term
        is_brand: $(options.element).data('is-brand')

      zzz = undefined
      zzz = results: []

      unless options.context?
        if options.page <= 1
          if options.term? && options.term.length > 0
            zzz.results.push
              id: options.term
              text: options.term
              new: true

      $.getJSON "/spare_infos/search/?" + $.param(params), (data) ->

        data.map (data) ->
          zzz.results.push
            id: data.name
            true_id: data.id
            text: data.name
            #thumb: data.image.thumb.url


        if data.length
          zzz.more = true

        options.callback zzz
