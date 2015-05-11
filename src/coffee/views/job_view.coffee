class JobView
  templateString = [
    '<img src="<%= icon_url %>">',
    '<a class="job-title" href="<%= url %>?via=chrome" target="_blank"><%= title %></a>',
  ].join('')
  compiled = _.template templateString

  constructor: (@json) ->
    @el = $('<li>').addClass('job list-group-item')

  render: ->
    @el.html(compiled @json)
    if @json.state is 'closed'
      @el.addClass('closed')
        .append $('<span class="label label-default">').text('募集終了')
    @

module.exports = JobView
