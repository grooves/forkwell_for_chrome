global.$ = global.jQuery = require 'jquery'
global._ = require 'underscore'
require 'bootstrap'

$ ->
  PopupView = require './views/popup_view'
  new PopupView().render()
