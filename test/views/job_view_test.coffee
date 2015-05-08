require 'test/helper'
JobView = require 'src/coffee/views/job_view'

describe 'JobView', ->
  describe '#render', ->
    it 'should render html', ->
      view = new JobView
        icon_url: 'icon_url'
        url: 'url'
        title: 'title'
      assert view.render().el.html() is '<img src="icon_url"><a class="job-title" href="url?via=chrome" target="_blank">title</a>'
