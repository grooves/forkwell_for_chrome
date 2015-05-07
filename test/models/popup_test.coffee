require 'test/helper'
Popup = require 'src/coffee/models/popup'

describe 'Popup', ->
  describe '#setJobs', ->
    popup = null

    beforeEach ->
      sinon.spy chrome.storage.local, 'set'
      sinon.spy chrome.browserAction, 'setBadgeText'
      popup = new Popup()
    afterEach ->
      chrome.storage.local.set.restore()
      chrome.browserAction.setBadgeText.restore()

    context 'when args have a job', ->
      jobs = [{title: 'title'}]

      beforeEach -> popup.setJobs(jobs)

      it 'should update jobs and badgeText', ->
        assert popup.jobs is jobs
        assert popup.badgeText is '1'

      it 'should update storage to jobs', ->
        assert chrome.storage.local.set.args[0][0].popup is jobs

      it 'should update badgeText to "1"', ->
        assert chrome.browserAction.setBadgeText.args[0][0].text is '1'

    context 'when args is undefined', ->
      beforeEach -> popup.setJobs undefined

      it 'should update jobs to null, and badgeText to ""', ->
        assert popup.jobs is null
        assert popup.badgeText is ''

      it 'should update storage to null', ->
        assert chrome.storage.local.set.args[0][0].popup is null

      it 'should update badgeText to ""', ->
        assert chrome.browserAction.setBadgeText.args[0][0].text is ''
