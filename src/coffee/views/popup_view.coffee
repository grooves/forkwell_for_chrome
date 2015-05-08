JobView = require './job_view'
NotFoundView = require './not_found_view'
Popup = require '../models/popup'

class PopupView
  render: ->
    popup = new Popup()
    popup.fetchJobs (jobs) ->
      if jobs
        for job in jobs
          $('#jobs').append new JobView(job).render().el
      else
        $('#jobs').append new NotFoundView().render().el

module.exports = PopupView
