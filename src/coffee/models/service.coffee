class Service
  @fetch: ->
    host = 'https://jobs.forkwell.com'
    url = "#{host}/api/v1/chrome/services.json"
    $.getJSON url, (json) ->
      chrome.storage.local.set json

  @findJobsByUrl: (url, callback) ->
    chrome.storage.local.get 'services', (items) =>
      jobs = items.services[@getOrigin(url)]
      callback jobs

  @getOrigin: (url) ->
    $('<a>', href: url)[0].origin

module.exports = Service
