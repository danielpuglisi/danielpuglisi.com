$ ->
  # Elastic Text Areas
  $("textarea").autogrow()

  # Nested fields
  $('form').on 'click', '.add_fields', (event) ->
    time = new Date().getTime()
    regexp = new RegExp($(this).data('id'), 'g')
    $('.links-list').prepend($(this).data('fields').replace(regexp, time))
    $("textarea").autogrow()
    event.preventDefault()

  $('form').on 'click', '.remove_field', (event) ->
    if confirm "Really wanna delete this link?"
      field = $(@).closest('.field')
      field.slideUp ->
        field.find('.input').remove() # otherwise chrome throws an exception if name or url are empty
        field.find('.destroy-link').val('1')
    event.preventDefault()

  $('form').on 'click', '.preview_field', (event) ->
    field = $(@).closest('.field')
    url = field.find('.input .url').val()
    window.open(url ,'_blank')
    event.preventDefault()

  # Sortable
  # this is a small hack; when a tr is dragged with jQuery UI sortable
  # the cells lose their width
  # cells = $('.table').find('tr')[0].cells.length
  # desired_width = 940 / cells + 'px'
  # $('.table td').css('width', desired_width)

  $('#sortable').sortable(
    # axis: 'y'
    # items: 'li'

    # highlight the row on drop to indicate an update
    stop: (e, ui) ->
      ui.item.find('.sub-header').effect('highlight', {}, 1000)
    update: (e, ui) ->
      item_id = ui.item.data('item-id')
      position = ui.item.index('.link')
      $.ajax(
        type: 'POST'
        url: $(this).data('update-url')
        dataType: 'json'

        # the :thing hash gets passed to @thing.attributes
        # row_order is the default column name expected in ranked-model
        data: { id: item_id, link: { issue_order_position: position } }
      )
  )
