class Popup
  setJobs: (jobs) ->
    if jobs
      @jobs = jobs
      @badgeText = "#{jobs.length}"
    else
      @jobs = null
      @badgeText = ''

    chrome.storage.local.set popup: @jobs
    chrome.browserAction.setBadgeText text: @badgeText

module.exports = Popup
