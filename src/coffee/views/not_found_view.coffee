class NotFoundView
  templateString = [
    '<div class="col-xs-12"><p class="text-center text-muted">このページに関連ある求人はありません</p></div>',
  ].join('')
  compiled = _.template templateString

  constructor: ->
    @el = $('<div>')

  render: ->
    @el.html(compiled())
    @
