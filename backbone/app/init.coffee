App = require 'app'

window.delay = (ms, func) ->
  setTimeout func, ms

window.coinbase_url = "https://coinbase.com/oauth/authorize?client_id=ed71f78e7a89b542777e77d93dc44a33c02bab2c855a4e9919c7db5ad50edb6a&redirect_uri=http%3A%2F%2Flocalhost%3A3000api%2Fcoinbase%2Fauth%2Fcallback&response_type=code"

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

  $.ajaxSetup
    type: "POST"
    data: {}
    dataType: 'json'
    crossDomain: true
    xhrFields:
      withCredentials: true

  # lol
  Backbone.$ = jQuery
  Pace.start()

  do App.start
