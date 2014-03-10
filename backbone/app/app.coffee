Router = require 'router'
User = require 'models/user'
Product = require 'models/product'

module.exports =
  start: ->

    user = new User
      validated_session: false

    init = ->
      router = new Router { user }
      do Backbone.history.start

    user.fetch
      async: false
      success: (response) ->
        do user.setValidSession
        do init
      error: (xhr, status, error) ->
        do init


