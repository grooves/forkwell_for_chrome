fetchFromForkwellJobs = ->
  host = 'https://jobs.forkwell.com'
  url = "#{host}/chrome/services.json"
  $.getJSON url, (json) ->
    chrome.storage.local.set json

updatePopupByUrl = (url) ->
  chrome.storage.local.get 'services', (items) ->
    origin = $('<a>', href: url)[0].origin
    jobs = items.services[origin]
    if jobs
      chrome.storage.local.set
        popup: jobs
      chrome.browserAction.setBadgeText
        text: "#{jobs.length}"
    else
      chrome.storage.local.set
        popup: null
      chrome.browserAction.setBadgeText
        text: ''

fetchFromForkwellJobs()

setInterval fetchFromForkwellJobs, 1000 * 60 * 60 * 24

chrome.tabs.onActivated.addListener (activeInfo) ->
  chrome.tabs.get activeInfo.tabId, (tab) ->
    updatePopupByUrl tab.url
