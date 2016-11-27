publisher = client.publish('/comments', {
  message: '<%= j render @post %>',
  token: '<%= @ticket.token %>'
});