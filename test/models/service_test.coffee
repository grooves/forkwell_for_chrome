require 'test/helper'
Service = require 'src/coffee/models/service'

describe 'Service', ->
  describe '.fetch', ->
    json = {}

    beforeEach ->
      sinon.stub($, 'ajax').yieldsTo('success', json)
      sinon.spy chrome.storage.local, 'set'
      Service.fetch()
    afterEach ->
      $.ajax.restore()
      chrome.storage.local.set.restore()

    it 'should call $.ajax with URL', ->
      assert $.ajax.args[0][0].url is 'https://jobs.forkwell.com/api/v1/chrome/services.json'

    it 'should update storage to json', ->
      assert chrome.storage.local.set.args[0][0] is json

  describe '.getOrigin', ->
    it 'should get origin from URL', ->
      origin = Service.getOrigin 'https://jobs.forkwell.com/jobs'
      assert origin is 'https://jobs.forkwell.com'
