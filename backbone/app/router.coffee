Nav = require 'views/nav'

module.exports = class Router extends Backbone.Router
  routes: ->
    '*hey': 'indexHandler'

  initialize: (options) ->
    @user = options.user

  indexHandler: ->
    nav = new Nav
      model: @user
    nav.render()



