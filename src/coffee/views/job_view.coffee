class JobView
  templateString = [
    '<img src="<%= icon_url %>">',
    '<a class="job-title" href="<%= url %>"><%= title %></a>',
  ].join('')
  compiled = _.template templateString

  constructor: (@json) ->
    @el = $('<li>').addClass('job list-group-item')

  render: ->
    @el.html(compiled @json)
    @
