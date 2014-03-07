App = require 'app'

window.delay = (ms, func) ->
  setTimeout func, ms

window.debug = !(window.location.hostname.indexOf('local') is -1)
console.log "DEBUG: #{window.debug}"

$ ->

  # lol
  Backbone.$ = jQuery

  do App.start
