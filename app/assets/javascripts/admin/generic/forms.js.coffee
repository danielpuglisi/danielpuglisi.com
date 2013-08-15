$ ->
  # Elastic Text Areas
  $("textarea").autogrow()

  # Nested fields
  $('form').on 'click', '.add_fields', (event) ->
    time = new Date().getTime()
    regexp = new RegExp($(this).data('id'), 'g')
    $(this).parent().after($(this).data('fields').replace(regexp, time))
    event.preventDefault()

  $('form').on 'click', '.remove_fields', (event) ->
    $(this).closest('.field').find('input[type=hidden]').val('1')
    $(this).closest('.field').hide()
    event.preventDefault()
