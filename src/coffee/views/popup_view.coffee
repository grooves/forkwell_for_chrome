JobView = require './job_view'
NotFoundView = require './not_found_view'

class PopupView
  render: ->
    chrome.storage.local.get 'popup', (items) ->
      if items.popup
        for job in items.popup
          $('#jobs').append new JobView(job).render().el
      else
        $('#jobs').append new NotFoundView().render().el

module.exports = PopupView
