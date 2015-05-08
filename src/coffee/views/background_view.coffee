Service = require '../models/service'
Popup = require '../models/popup'

class BackgroundView
  INTERVAL_TIME = 1000 * 60 * 60 * 24

  render: ->
    Service.fetch()
    setInterval (-> Service.fetch()), INTERVAL_TIME

    chrome.tabs.onActivated.addListener (activeInfo) ->
      chrome.tabs.get activeInfo.tabId, (tab) ->
        Service.findJobsByUrl tab.url, (jobs) ->
          popup = new Popup()
          popup.setJobs jobs

    chrome.tabs.onUpdated.addListener (tabId, changeInfo, tab) ->
      Service.findJobsByUrl tab.url, (jobs) ->
        popup = new Popup()
        popup.setJobs jobs

module.exports = BackgroundView
