window.client = new Faye.Client('/faye')

jQuery ->
  client.subscribe '/comments', (payload) ->
    $('.ticket-' + payload.token + ' .no-posts').remove()

    $('<div></div>')
      .css({'backgroundColor' : '#ff9f5f'})
      .prependTo('.ticket-' + payload.token + ' .posts')
      .hide()
      .append(payload.message)
      .fadeIn('slow')
      .css({transition: 'background-color 3s ease-in-out', "background-color": "white"})