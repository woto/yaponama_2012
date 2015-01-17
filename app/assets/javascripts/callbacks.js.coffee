form = '''
  <form id='callback_form' data-remote='true' action='/callbacks' method='post' class="form-horizontal">
    <div class="form-group">
      <label for="callback_name" class="col-sm-3 control-label">Имя</label>
      <div class="col-sm-6">
        <input type="text" name="callback[name]" class="form-control" id="callback_name">
        <span class="help-block">Представьтесь пожалуйста</span>
      </div>
    </div>
    <div class="form-group">
      <label for="callback_phone" class="col-sm-3 control-label">Телефон</label>
      <div class="col-sm-6">
        <input type="text" name="callback[phone]" class="form-control" id="callback_phone">
        <span class="help-block">Укажите контактный телефон для связи</span>
      </div>
    </div>
  </form>
'''

$(document).on "click", ".callback-link", (e) ->
  e.preventDefault()
  bootbox.dialog
    message: form
    title: 'Заказ обрабтного звонка'
    buttons:
      success:
        label: 'Перезвоните мне'
        className: 'btn-primary'
        callback: ->
          inputs = [$('#callback_phone'), $('#callback_name')]

          # Отмечаем поля с ошибками
          for input in inputs
            unless input.val()
              $(input).closest('.form-group').addClass('has-error')
            else
              $(input).closest('.form-group').removeClass('has-error')

          # Блокируем отправку если не все поля валидны
          if _.all(inputs, (input) ->
            input.val()
          )
            #csrf_param = $('meta[name="csrf-param"]').attr('content')
            #csrf_token = $('meta[name="csrf-token"]').attr('content')
            #$('#callback_form').append('<input type="hidden" name="' + csrf_param + '" value="' + csrf_token + '">')
            $('#callback_form').trigger('submit.rails')
          else
            false
      cancel:
        label: 'Отмена'
        className: 'btn-default'
        callback: ->
