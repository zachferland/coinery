App = require 'app'

window.delay = (ms, func) ->
  setTimeout func, ms

window.api_root = 'http://app.coinery.io'
window.cb_client_id = 'ed71f78e7a89b542777e77d93dc44a33c02bab2c855a4e9919c7db5ad50edb6a'

window.debug = !(window.location.hostname.indexOf('local') is -1)

if window.debug
  window.api_root = 'http://localhost:3000'
  window.cb_client_id = "6941cf4b2f490600c5f4b0bc2f39ada655782a3487426948bf7a94858f40f0d2"

window.cb_auth_url = "https://coinbase.com/oauth/authorize?client_id=#{window.cb_client_id}&redirect_uri=#{encodeURIComponent(window.api_root+'/api/coinbase/auth/callback')}&response_type=code&scope=merchant"

# designer probz
window.sexyHash = ->

  stripBad = (string) ->
    return "/#{string}" unless string.charAt(0) in ['#', '/']
    stripBad(string.slice(1))

  location.hash = stripBad(location.hash)

window.sexyHash()


jQuery.fn.selectText = ->
  doc = document
  element = this[0]
  if doc.body.createTextRange
    range = document.body.createTextRange()
    range.moveToElementText element
    range.select()
  else if window.getSelection
    selection = window.getSelection()
    range = document.createRange()
    range.selectNodeContents element
    selection.removeAllRanges()
    selection.addRange range
  return


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
