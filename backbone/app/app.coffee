Router = require 'router'
User = require 'models/user'

module.exports =
  start: ->

    user = new User()
    # TODO: syncronously fetch user

    router = new Router { user }

    Backbone.history.start
      pushState: true
