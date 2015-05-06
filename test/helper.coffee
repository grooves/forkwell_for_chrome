global.assert = require 'power-assert'

global.$ = require('jquery')(require('jsdom').jsdom().parentWindow)
global._ = require 'underscore'
