require 'test/helper'
NotFoundView = require 'src/coffee/views/not_found_view'

describe 'NotFoundView', ->
  describe '#render', ->
    it 'should render html', ->
      view = new NotFoundView()
      assert view.render().el.html() is '<div class="col-xs-12"><p class="text-center text-muted">このページに関連ある求人はありません</p></div>',
