global.assert = require 'power-assert'
global.sinon = require 'sinon'
global.context = describe

global.$ = require('jquery')(require('jsdom').jsdom().parentWindow)
global._ = require 'underscore'

global.chrome =
  storage:
    local:
      set: ->
      get: ->
  browserAction:
    setBadgeText: ->
