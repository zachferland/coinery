App = require 'app'

window.delay = (ms, func) ->
  setTimeout func, ms

window.debug = !(window.location.hostname.indexOf('local') is -1)
console.log "DEBUG: #{window.debug}"

# designer probz
window.sexyHash = ->

  stripBad = (string) ->
    return "/#{string}" unless string.charAt(0) in ['#', '/']
    stripBad(string.slice(1))

  location.hash = stripBad(location.hash)

window.sexyHash()

$ ->

  # http://elving.me/post/44859632208/rethinking-backbone-js-view-rendering

  Handlebars.registerHelper 'get', (attr) ->
    this.get(attr)

  Handlebars.registerHelper 'do', (method) ->
    this[method]

  Handlebars.registerHelper 'using', (attr, options) ->
    data = {}
    data[attr] = this.get(attr)
    options.fn(data)


  # lol
  Backbone.$ = jQuery

  do App.start
