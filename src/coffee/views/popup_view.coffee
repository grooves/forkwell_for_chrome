JobView = require './job_view'
NotFoundView = require './not_found_view'
Popup = require '../models/popup'

class PopupView
  render: ->
    popup = new Popup()
    popup.fetchJobs (jobs) ->
      if jobs
        closed_job_count = jobs.filter (job) ->
          job.state is 'closed'
        .length

        for job in jobs
          $('#jobs').append new JobView(job).render().el

        link = $('<a class="closed-job-link text-muted">').attr('href', '#')
          .text("募集終了 #{closed_job_count}件")
          .on 'click', ->
            $('.job.closed').toggle()
        $('#jobs').after link
      else
        $('#jobs').append new NotFoundView().render().el

module.exports = PopupView
